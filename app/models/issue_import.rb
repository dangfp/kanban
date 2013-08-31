class IssueImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_issues.map(&:valid?).all?
      imported_issues.each(&:save!)
      true
    else
      imported_issues.each_with_index do |issue, index|
        issue.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_issues
    @imported_issues ||= load_imported_issues
  end

  def load_imported_issues
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      issue = Issue.find_by_id(row["id"]) || Issue.new
      issue.attributes = row.to_hash.slice(*Issue.accessible_attributes)
      issue
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    #when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore).each(project_id: Issue.project.name) {|hash| arr << hash}
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
