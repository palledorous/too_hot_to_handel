class TooHotToHandel::CLI

  def initialize
    line_width = 74
    puts ""
    puts ""
    puts 'Welcome to'.blue
    puts' ______        ,             ______   ,                              _ '.blue
    puts'(_) |         /|   |        (_) |    /|   |                  |      | |'.blue
    puts'    | __   __  |___|  __ _|_    | __  |___|  __,   _  _    __|   _  | |'.blue
    puts'  _ |/  \_/  \_|   |\/  \_|   _ |/  \_|   |\/  |  / |/ |  /  |  |/  |/ '.blue
    puts' (_/ \__/ \__/ |   |/\__/ |_/(_/ \__/ |   |/\_/|_/  |  |_/\_/|_/|__/|__/'.blue
    puts ""
    puts ("Bringing the latest classical music news straight to your command line!".center(line_width))
    puts ""
    puts ("To begin, type 'menu'".center(line_width))
    puts ""
    puts ("To exit, type 'exit'.".center(line_width))
    puts ""
  end

  def call
    user_input = []

    while user_input != "exit"

      user_input = gets.strip.downcase

      case user_input
      when "menu"
        list_articles
      when user_input.to_i <= 10
        view_content
      when "exit"
        puts "It has been a pleasure. Please come back soon!".blue
        puts ""
        puts ""
      else
        puts ""
        puts "I didn't understand that. Please try again.".blue
      end
    end
  end

  def prepare_articles
    TooHotToHandel::Scraper.scrape_classical_reviews if TooHotToHandel::ClassicalReview.all.count == 0
  end

  def list_articles
    prepare_articles

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title.blue}"
      puts ""
      puts "    #{review.blurb}"
      puts ""
    end
    puts ""
    puts "To read an article, enter the corresponding number (1 - 10) ...".blue
    puts ""
    view_content
  end

  def view_content
    user_input = gets.strip.downcase

    index = user_input.to_i-1 || "#{classical_review.name.downcase}"

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    TooHotToHandel::Scraper.scrape_review_content(classical_review) if !classical_review.content

    puts classical_review.content

    puts ""
    puts "To view the list again, enter 'menu'".blue
    puts ""
  end
end
