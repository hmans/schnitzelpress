require_relative 'test_helper'

context Schreihals::Document do
  helper(:test_document_directory) { File.expand_path('../files/', __FILE__) }
  helper(:test_document_filename) { File.join(test_document_directory, 'simple_document.md')  }
  helper(:test_document_contents) { open(test_document_filename).read }

  setup { Schreihals::Document }

  context "#from_string" do
    setup { topic.from_string open(test_document_filename).read }

    asserts(:class).equals Schreihals::Document
    asserts(:body).equals "This is the body."
    asserts(:title).equals "This is the title"
    asserts("automatically converts dates into Date objects") { topic.date.kind_of? Date }
    asserts("automatically converts datetimes into Time objects") { topic.datetime.kind_of? Time }
  end

  asserts "#from_file should call #from_string with the contents of the file" do
    mock.proxy(topic).from_string(test_document_contents, { 'file_name' => 'simple_document.md' })
    topic.from_file(test_document_filename)
  end.kind_of?(Schreihals::Document)

  context "#from_file" do
    setup { topic.from_file(test_document_filename) }

    asserts(:file_name).equals "simple_document.md"
    asserts(:file_name_without_extension).equals "simple_document"
    asserts(:file_extension).equals "md"
  end

  context "#load_from_directory" do
    should "call #from_file for each file contained in the directory" do
      Dir[File.join(test_document_directory, "*")].each do |f|
        mock.proxy(topic).from_file(f)
      end
      topic.load_from_directory(test_document_directory)
    end.kind_of?(Array)
  end
end
