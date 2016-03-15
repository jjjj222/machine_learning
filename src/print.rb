#class Float
#
#    def to_2
#        return sprintf("%0.02f", self)
#    end
#end

#------------------------------------------------------------------------------
#   printer
#------------------------------------------------------------------------------
class Printer
    def initialize(width)
        @width = width
    end

    def draw_line(text, c)
        rest = @width - text.length - 2
        rest_left = rest / 2
        rest_right = rest - rest_left

        puts "#{c * rest_left} #{text} #{c * rest_right}"
    end

    def draw_box(text, c)
        rest = @width - text.length - 2
        rest_left = rest / 2
        rest_right = rest - rest_left

        puts c * @width
        puts "#{c}#{' ' * rest_left}#{text}#{' ' * rest_right}#{c}"
        puts c * @width
    end

    def draw_table(data, header)
        widths = get_widths(data + header)
        total_width = widths.inject(0) { |sum, elt| sum += elt}
            + 3 * widths.length + 1

        draw_table_line(widths)
        header.each do |row|
            draw_table_row_left(row, widths)
        end

        draw_table_line(widths)
        data.each do |row|
            draw_table_row(row, widths)
        end
        draw_table_line(widths)
    end

    def draw_table_line(widths)
        print "+"
        widths.each do |width|
            print "-" * (width+2)
            print "+"
        end
        puts
    end

    def draw_table_row_left(row, widths)
        print "|"
        widths.each_with_index do |width, i|
            print " #{row[i].to_s.ljust(width)} |"
        end
        puts
    end

    def draw_table_row(row, widths)
        print "|"
        widths.each_with_index do |width, i|
            print " #{row[i].to_s.rjust(width)} |"
        end
        puts
    end

    private
    def get_widths(rows)
        widths = Array.new(rows[0].length, 0)

        rows.each do |row|
            row_widths = row.map {|elt| elt.to_s.length}
            widths = [widths, row_widths].transpose.map(&:max)
        end

        return widths
    end
end
