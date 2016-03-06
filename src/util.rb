#------------------------------------------------------------------------------
#   dump
#------------------------------------------------------------------------------
module Enumerable
    def dump
        if self.empty?
            puts "<empty>"
        else
            self.each_with_index do |line, i|
                print "#{i} : "
                print line
                puts
            end
        end
    end

    #def dump_indent(indent)
    #    self.each_with_index do |line, i|
    #        print "#{indent}#{i} : "
    #        print line
    #        puts
    #    end
    #end
end

#------------------------------------------------------------------------------
#   parse
#------------------------------------------------------------------------------
class IO
    def self.parse_data(file)
        begin
            lines = IO.readlines(file)
        rescue
            puts "Error: Can't open file \"#{file}\" !!"
            exit
        end

        data = lines.map do |line|
            line.rstrip.gsub(/\s+/, "").split(",")
        end
        return data
    end
end

