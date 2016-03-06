class ErrorMsg
    def self.file_line(file, line, msg)
        puts "Error: In file \"#{file}\" line #{line}: #{msg} !!"
    end
end
