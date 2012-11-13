(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:en]).each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-executives').blank?
        user.plugins.create(:name => 'refinerycms-executives',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  url = "/executives"
  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => url).empty?
    page = Refinery::Page.create(
      :title => 'Executives',
      :link_url => url,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end
end

Refinery::Executives::Executive.create(name: "Barack Hussein Obama II",
                                       title: "President of the United States",
                                       spouse: "Michelle Obama",
                                       website: "http://www.whitehouse.gov/administration/president-obama/",
                                       webform: "http://www.whitehouse.gov/contact/submit-questions-and-comments",
                                       email: "",
                                       facebook: "https://www.facebook.com/barackobama",
                                       twitter: "https://twitter.com/BarackObama")

Refinery::Executives::Executive.create(name: "Joseph Robinette \"Joe\" Biden, Jr.",
                                       title: "Vice President of the United States",
                                       spouse: "Jill Jacobs",
                                       website: "http://www.whitehouse.gov/administration/vice-president-biden/",
                                       webform: "http://www.whitehouse.gov/contact/submit-questions-and-comments",
                                       email: "",
                                       facebook: "https://www.facebook.com/joebiden",
                                       twitter: "https://twitter.com/joebiden")

Refinery::Executives::Executive.create(name: "John Boehner",
                                       title: "Speaker of the United States House of Representatives",
                                       spouse: "Deborah Gunlack",
                                       website: "http://www.speaker.gov/",
                                       webform: "http://www.johnboehner.com/",
                                       email: "",
                                       facebook: "https://www.facebook.com/johnboehner",
                                       twitter: "https://twitter.com/johnboehner")


