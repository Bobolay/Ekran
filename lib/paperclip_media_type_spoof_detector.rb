module Paperclip
  class MediaTypeSpoofDetector
    def type_from_file_command
      begin
        Paperclip.run("file", "-b --mime :file", :file => @file.path)
      rescue Cocaine::CommandLineError
        ""
      end
    end

    def spoofed?
      false
    end
  end
end