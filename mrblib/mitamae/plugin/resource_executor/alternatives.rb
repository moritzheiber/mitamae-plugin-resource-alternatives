module ::MItamae
  module Plugin
    module ResourceExecutor
      class Alternatives < ::MItamae::ResourceExecutor::Base
        Error = Class.new(StandardError)

        def apply
          if desired.auto
            if !current.auto
              run_command(["update-alternatives", "--auto", desired.name])
            end
          else
            if current.auto || desired.path != current.path
              run_command([
                "update-alternatives", "--set", desired.name,
                desired.path,
              ])
            end
          end
        end

        def set_current_attributes(current, action)
          result = parse_entry(
            run_command(
              ["update-alternatives",
               "--query",
               attributes.name
              ]
            ).stdout[/.*?(?=\n\n)/m])

          case result[:status]
          when "manual"
            current.auto = false
          when "auto"
            current.auto = true
          else
            raise Error, "Malformed status: #{result[:status].inspect}"
          end
          if !current.auto
            current.path = result[:value]
          end
        end

        def set_desired_attributes(desired, action)
          desired.path = attributes.path
          desired.name = attributes.name
          desired.auto = attributes.auto
        end

        private

        def parse_entry(entry)
          last_key = nil
          return entry.each_line.each_with_object({}) do |l, h|
            case l.chomp
            when /: /
              key = $`.downcase.to_sym
              value = $'
              h[key] = value
              last_key = key
            when /:\z/
              last_key = $`.downcase.to_sym
            when /\A /
              h[last_key] ||= []
              h[last_key] << $'
            else
              raise Error, "malformed line: '#{l.inspect}'"
            end
          end
        end
      end
    end
  end
end
