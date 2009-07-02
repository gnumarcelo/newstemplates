module Spec
  module Rails
    module Matchers
      
      def belong_to(expected)
        BelongTo.new(expected)
      end
      
      def have_many(expected)
        HaveMany.new(expected)
      end

      def have_one(expected)
        HaveOne.new(expected)
      end

      def have_and_belong_to_many(expected)
        HaveAndBelongToMany.new(expected)
      end

      class AssociationMatcher
        def initialize(association_klass)
          case association_klass.class.name
          when "Symbol"
            @association_klass = Kernel.const_get(association_klass.to_s.classify)
          when "Class"
            @association_klass = association_klass
          else
            raise "Passed a #{association_klass.class.name}, expected Symbol or Class"
          end
        end
        
        def plural?
          self.class.name =~ /many/i
        end
        
        def association_klass_name
          name = @association_klass.name.downcase
          name = name.pluralize if plural?
          name
        end
        
        def desc
          self.class.name.split("::").last.titlecase.downcase + " " + association_klass_name
        end
        
        def description
          desc + " (" + @klass.name + ")"
        end
        
        def failure_message
          "expected #{@klass.name} to #{desc}"
        end
      end

      class BelongTo < AssociationMatcher
        def matches?(klass)
          @klass = klass
          through ||= @association_klass.to_s.underscore
          inverse ||= @klass.to_s.underscore.pluralize
          through_assign = through + "="
          
          k = @klass.new
          item = @association_klass.new
          k.save(false)
          item.save(false)
          
          k.send(through_assign, item)
          item.send(inverse).push(k)
          
          k.send(through).should === item
          item.send(inverse).length.should === 1
          
          k.send(through_assign, nil)
          k.save(false)
          
          k.destroy
          item.destroy

          # if we get this far, the association is valid, so return true
          # TODO run this in a proc/lambda to check for errors and implement negative_failure_messge
          true
        end
      end

      class HaveMany < AssociationMatcher
        def matches?(klass)
          @klass = klass
          
          through ||= @association_klass.to_s.underscore.pluralize
          inverse ||= @klass.to_s.underscore
          inverse_assign = inverse + "="

          k = @klass.new
          item = @association_klass.new
          k.save(false)
          item.save(false)

          k.send(through) << item
          item.send(inverse_assign, k)
          k.save(false)
          item.save(false)

          k.send(through).length.should == 1
          k.send(through)[0].should === item

          item.send(inverse).should === k
          k.send(through).pop
          k.save(false)

          k.send(through).length.should == 0

          k.destroy
          item.destroy

          # if we get this far, the association is valid, so return true
          # TODO run this in a proc/lambda to check for errors and implement negative_failure_messge
          true
        end
      end

      class HaveOne < AssociationMatcher
        def matches?(klass)
          @klass = klass
          
          through ||= @association_klass.to_s.underscore
          through_assign = through + "="

          inverse ||= @klass.to_s.underscore
          inverse_assign = inverse + "="

          k = @klass.new
          item = @association_klass.new
          k.save(false)
          item.save(false)

          k.send(through_assign, item)
          item.send(inverse_assign, item)

          k.send(through).should_not be_nil
          k.send(through).should === item

          item.send(inverse).should === k
          k.send(through_assign, nil)
          k.save(false)

          k.send(through).should be_nil

          k.destroy
          item.destroy

          # if we get this far, the association is valid, so return true
          # TODO run this in a proc/lambda to check for errors and implement negative_failure_messge
          true
        end
      end
      
      class HaveAndBelongToMany < AssociationMatcher
        def matches?(klass)
          @klass = klass
          
          through ||= @association_klass.to_s.underscore.pluralize
          inverse ||= @klass.to_s.underscore.pluralize
          inverse_assign = inverse + "="

          k = @klass.new
          item = @association_klass.new
          k.save(false)
          item.save(false)

          k.send(through) << item
          k.save(false)
          item.save(false)

          k.send(through).length.should == 1
          k.send(through)[0].should === item

          item.send(inverse).length.should == 1
          item.send(inverse)[0].should === k
          k.send(through).pop
          k.save(false)

          k.send(through).length.should == 0

          k.destroy
          item.destroy

          # if we get this far, the association is valid, so return true
          # TODO run this in a proc/lambda to check for errors and implement negative_failure_messge
          true
        end
      end
    end
  end
end
