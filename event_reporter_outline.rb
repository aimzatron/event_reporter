###Aimee Maher
###2-7-2013
###Event Reporter Project

require "csv"

@contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
@file = []
 

def welcome_message
    "Welcome to Event Reporter"
  end

  def quit_command
    "q"
  end

  def get_command_from_user
    printf "What would you like to do?"
    input = gets.chomp
    parts = input.split(" ")
    command = parts[0]
  end

   def parse_command(input)
    parts = input.split(" ") 
    return parts[0], parts[1..-1]
  end

  def load
   @contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

   @contents.each do |row|
    entry = {}
    entry[:first_name] = row[2]
    entry[:last_name] = row[3]
    entry[:email_address] = row[4]
    entry[:homephone]= clean_phone_numbers(row[5])
    entry[:street] = row[6]
    entry[:city] = row[7]
    entry[:state] = row[8]
    entry[:zipcode] = clean_zipcode(row[9])
    @file.push(entry)
  end
    puts "File loaded"
  end

  def count_queue_records
    count = @queue.count
    puts "You have #{count} in the queue"
  end

  def clear_queue_records
    puts "#{@file.clear} The queue has been cleared"
  end

    def clean_phone_numbers(homephone)
    homephone.gsub!(/[()-." "]/, '')
     if homephone.length == 10
    homephone
     elsif homephone.length == 11
       if homephone[0] == "1"
    homephone = homephone[1..-1]
         elsif homephone[0] == "2,3,4,5,6,7,8,9"
    homephone = homephone "bad"
    end 
     else
    homephone = "0000000000"
   end
  end

 def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
 end  

def print_queue
  @contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
  puts "FIRST NAME\tLAST NAME\tEMAIL\tPHONE NUMBER\tADDRESS\tCITY\tSTATE\tZIPCODE"
  @queue.each do |line|
      
      first_name = (line[:first_name])
      last_name = (line[:last_name])
      email = (line[:email_address])
      phone_num = clean_phone_numbers(line[:homephone])
      address = (line[:street])
      city = (line[:city])
      state = (line[:state])
      zip = clean_zipcode(line[:zipcode])

      puts "#{first_name} #{last_name} #{email} #{phone_num} #{address} #{city} #{state} #{zip}"
	 end
  end

	#l.justified, size determined by largest entry in each column
	#if queue returns 10+ results, user press spacebar to continue
	#print "Showing Results num1 of total" on bottom of results page
	#add add/subtract feature to results page
	#allow user to find certain items within their results
 

  def parse_csv(event_attendees)
    first_name = [:first_Name]
    last_name = [:last_Name]
    email = [:Email_Address]
    phone_num = [:homephone]
    address = [:Street]
    city = [:City]
    state = [:State]
    zip = [:Zipcode]
  end

  def print_queue_attr
	puts "Do you want to print an attribute and criteria?(y/n): "
    findit = gets.chomp
    @queue = []
    if findit =~ /^[yY]/
    puts "Enter attribute(e.g.- zip) and criteria(e.g.- 80124) separated by a comma: "
    attribute,criteria = gets.chomp.split(",")
    @file.each do |row|
       if row[attribute.to_sym] == criteria
        @queue.push(row)
      end
    end     
    puts @queue
  end
end

  def save_queue_to
   myqueue = CSV.open("mystring.csv", "w")
   myqueue << @queue
   myqueue.close
  end

  def find_attribute
    puts "Do you want to find an attribute and criteria?(y/n): "
    findit = gets.chomp
    @queue = []
    if findit =~ /^[yY]/
    puts "Enter attribute(e.g.- zip) and criteria(e.g.- 80124) separated by a comma: "
    attribute,criteria = gets.chomp.split(",")
    @file.each do |row|
       if row[attribute.to_sym] == criteria
        @queue.push(row)
      end
    end     
    count = @queue.count
    puts "Found #{count} result(s)"
  end
end

 def execute_input(command, rest_of_input, quit_command)
    case command
    when quit_command then puts "Thank you! Come again some time!"
    when 'load' then load
    when 'help' then help_desc
    when 'helpf' then help_find 
    when 'helpqco' then help_queue_count
    when 'helpqcl' then help_queue_clear
    when 'helpqpr' then help_queue_print
    when 'helpqsave' then help_queue_save
    when 'f' then find_attribute
    when 'qco' then count_queue_records
    when 'qcl' then clear_queue_records
    when 'qpr' then print_queue
    when 'qpra' then print_queue_attr
    when 'qsave' then save_queue_to
    when 'q' then quit_command
    else
      puts "Sorry, I don't know how to #{command}. Please select an existing command or type 'help' for more info!"
    end
  end  

  def run
    puts welcome_message
    command = ""
    while command != quit_command
      input = get_command_from_user
      command, rest_of_input = parse_command(input)
      execute_input(command, rest_of_input, quit_command)
    end 
  end

 def help_desc
    puts "Guide to Event Reporter commands:\n load..............loads the file of your choice \n help..............shows the guide of Event Reporter commands \n help_attribute....shows information regarding the specified attribute \n f.................allows the user to find attributes/criteria in the queue \n qco...............counts the amount of lines in the queue \n qcl...............clears out the current items in the queue \n qpr...............prints the items in a pre-set tabbed document \n qpra..............prints queue by attribute \n q.................quit \n qsave.............prints queue and allows the user to save the document"
  end

  def help_find
    puts "Find helps you locate items in the document! There are a few ways to do this: \n Type in an attribute and criteria (e.g. Last_Name,Miller) \n Type multiple attributes and criteria separated by a comma (e.g. Last _Name, Johnson and Zipcode, 80124) to locate items with only those criteria. \n Type your attribute or criteria (e.g. Last_Name, Johnson or Zipcode, 80124) to locate items containing either criteria. \n Type one attribute with multiple criteria (Zipcode 80111,80122,80008)"
  end

  def help_queue_count
    puts "Type 'qco' to output how many records are in the current queue"
  end

  def help_queue_clear
    puts "Type 'qcl' to clear all the records in the current queue"
  end

  def help_queue_print
    puts "Typing 'qpr' will print an tabbed document in the order of Last Name, First Name, Email, Zipcode, City, State, Address, Phone \n Typing 'Print Queue' followed by any attribute (e.g.- Print Queue Zipcode) will organize the printed queue by the specified attribute."
  end

  def help_queue_save
    puts "Typing 'qsave' will prompt you for an option to save your queue to the location of your choice as a .csv, .txt, .json or.xml file."
  end

# command prompt
# 	-load -> erase loaded data & parse file (no file name = event_attendees.csv)
# 	-help -> listing of available commands 
# 	-help <command>- Descriptions of specific commands
# 				-find
# 				-queue count - how many records in the current queue
# 				-queue clear - empty the queue
# 				-queue print - 
# 				-queue save to <filename.csv>
# 	-find -> by Attribute (e.g.- Zip) and Criteria (e.g- 80124)
# 					- Case insensitive
# 					- insensitive to internal white space (e.g.- "John ")
# 					- Sensitive to external white space (e.g.- "johnpaul")
# 					- allow the use of "and"
# 					- allow multiple attr variable values eg- (80124, 89122)
# 					- allow users to select any records containing and attribute or a criteria
# 	-queue -> queue commands:
# 				-queue count- # of records in the current queue
# 				-queue clear- empty the queue
# 				-queue print- prints tabbed table with header row as follows:
# 						- 1, Last Name, First Name, Email, Zip, City, State, Address, Phone
# 						- columns should be aligned left and size should be determined by       longest entry in the column
# 						- if queue returns 10+ results, pause after 10 until user hits spacebar 
# 						- add status line that reads "Showing Result 20 of 86"
# 						- allow user to remove criteria using subtract or add additional criteria using add where results are displayed
# 						- allow user to find certain items within the results (eg - "80124")
# 				-queue print by <attr>- prints data table sorted by specified attr
# 				-queue save to <filename> - exports to specified file
										  # - save as csv, txt, json or xml

run

