require 'zip/zip'
require 'zip/zipfilesystem'
require 'tempfile'
require 'net/ftp'
require 'fileutils'
require 'open3'

class PreviewController < ApplicationController
  def reopen
    @edition = Edition.find(params[:id])
    @edition.reopen!
    render :text => "OK"
  end

  def close
    @edition = Edition.find(params[:id])
    @edition.close!
    render :text => "OK"
  end

  def index
    @edition = Edition.find(params[:id])

    # Remove old template files.
    FileUtils.rm_r("#{RAILS_ROOT}/public/preview/index/files") 

    # Copy template files to public dir.
    FileUtils.cp_r(
    "#{RAILS_ROOT}/app/views/templates/#{@edition.newsletter.template}/files", 
    "#{RAILS_ROOT}/public/preview/index/files")


    articles = @edition.articles

    template_params = {
      :partial => "/templates/#{@edition.newsletter.template}/article.html.erb", 
      :collection => articles, 
      :layout => "/templates/#{@edition.newsletter.template}/index.html.erb"
    }

    case params[:view]
    when 'preview'
      session[:assets] = 'files/'
      respond_to do |f|
        f.html { render template_params }
        f.pdf do
          prince = Prince.new
          prince.add_style_sheets("lib/prince.css")
          send_data prince.pdf_from_string(render_to_string(template_params))
        end
      end
    when 'export', 'upload'
      if params[:view] === 'export'
        session[:assets] = ""
      else
        session[:assets] = @edition.newsletter.assets
      end

      content = render_to_string(template_params)
      content_file_with_print_stylesheet = Tempfile.new("index")
      content_file_with_print_stylesheet.write content
      content_file_with_print_stylesheet.close

      content.gsub!(%{<link rel="stylesheet" type="text/css" href="files/print.css" media="print">}, "")

      content_file_without_print_stylesheet = Tempfile.new("index")
      content_file_without_print_stylesheet.write content
      content_file_without_print_stylesheet.close

      if params[:view] === 'export'
        send_file content_file_without_print_stylesheet.path, :filename => 'index.html'
      else
        url = @edition.newsletter.url
        raise "newsletter url needed to upload" if url.nil?

        base_dir = url.gsub("http://bloxham.ie/", "/httpdocs/")
        year_dir = base_dir + @edition.published_on.strftime("/%Y/")
        month_dir = year_dir + @edition.published_on.strftime("%m/")
        day_dir = month_dir + @edition.published_on.strftime("%d/")
        pdf_dir = base_dir + "/pdf" + @edition.published_on.strftime("/%Y/")

        ftp = Net::FTP.new(FTP_DOMAIN, FTP_USERNAME, FTP_PASSWORD)
        re { ftp.mkdir(year_dir) }
        re { ftp.mkdir(month_dir) }
        re { ftp.mkdir(day_dir) }
        re { ftp.mkdir(pdf_dir) }

        # Upload HTML version of newsletter.
        ftp.puttextfile(content_file_without_print_stylesheet.path, day_dir + 'index.html')

        # Upload PDF version of newsletter
        prince = Prince.new
        prince.add_style_sheets("lib/prince.css")
        pdf_filename = prince.pdf_from_file(content_file_with_print_stylesheet.path)
        ftp.putbinaryfile(pdf_filename, pdf_dir + @edition.pdf_filename)

        # Clean up
        ftp.close

        @result = @edition.create_campaign

        render :text => @result.inspect, :layout => true
      end
    else
      raise params[:view].to_s
    end
  end

  def download_files
    @edition = Edition.find(params[:id])

    `rm #{RAILS_ROOT}/public/files.zip`
    `zip -j #{RAILS_ROOT}/public/files.zip #{RAILS_ROOT}/app/views/templates/#{@edition.newsletter.template}/files/*`

    send_file "#{RAILS_ROOT}/public/files.zip"
  end
end

def re
  begin
    yield
  rescue Net::FTPPermError
  end
end
