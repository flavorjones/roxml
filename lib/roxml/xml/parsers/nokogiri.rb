require 'nokogiri'

module ROXML
  module XML # :nodoc:all

    Document = Nokogiri::XML::Document
    Node = Nokogiri::XML::Node

    class Node
      # TODO: reopening Nokogiri::XML::Node is offensive and possibly dangerous.
      def search(xpath)
        begin
          if document.namespaces['xmlns'] && !xpath.include?(':')
            xpath(namespaced(xpath), {'xmlns' => document.namespaces['xmlns']})
          else
            xpath(xpath)
          end
        rescue Exception => ex
          raise ex, xpath
        end
      end

      alias_method :remove!, :unlink

    private
      def namespaced(xpath)
        xpath.between('/') do |component|
          if component =~ /\w+/ && !component.include?(':') && !component.starts_with?('@')
            in_default_namespace(component)
          else
            component
          end
        end
      end

      def in_default_namespace(name)
        "xmlns:#{name}"
      end
    end

    class Parser
      class << self
        def parse(str_data)
          Nokogiri::XML(str_data)
        end

        def parse_file(path)
          Nokogiri::XML(File.open(path))
        end

        def parse_io(stream)
          Nokogiri::XML(stream)
        end
      end
    end

  end
end
