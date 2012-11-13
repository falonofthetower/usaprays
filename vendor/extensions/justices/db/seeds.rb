(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:en]).each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-justices').blank?
        user.plugins.create(:name => 'refinerycms-justices',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  url = "/justices"
  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => url).empty?
    page = Refinery::Page.create(
      :title => 'Justices',
      :link_url => url,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end
end

Refinery::Justices::Justice.create(name: "John G. Roberts, Jr.", 
                                   title: "Chief Justice of the United States",
                                   spouse: "Jane Marie Sullivan")

Refinery::Justices::Justice.create(name: "Antonin Scalia", 
                                   title: "Associate Justice",
                                   spouse: "Maureen McCarthy")

Refinery::Justices::Justice.create(name: "Anthony M. Kennedy", 
                                   title: "Associate Justice",
                                   spouse: "Mary Davis")

Refinery::Justices::Justice.create(name: "Clarence Thomas", 
                                   title: "Associate Justice",
                                   spouse: "Virginia Lamp")

Refinery::Justices::Justice.create(name: "Ruth Bader Ginsburg", 
                                   title: "Associate Justice",
                                   spouse: "Martin D. Ginsburg")

Refinery::Justices::Justice.create(name: "Stephen G. Breyer", 
                                   title: "Associate Justice",
                                   spouse: "Joanna Hare")

Refinery::Justices::Justice.create(name: "Samuel Anthony Alito, Jr.", 
                                   title: "Associate Justice",
                                   spouse: "Martha-Ann Bomgardner")

Refinery::Justices::Justice.create(name: "Sonia Sotomayor", 
                                   title: "Associate Justice",
                                   spouse: "")

Refinery::Justices::Justice.create(name: "Elena Kagan", 
                                   title: "Associate Justice",
                                   spouse: "")

