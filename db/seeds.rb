# frozen_string_literal: true

require "open-uri"

puts "Seeding database..."

# Admin user
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.password = "admin123"
admin.password_confirmation = "admin123"
admin.role = :admin
admin.save!
puts "  Admin user: admin@example.com / admin123"

# Site settings
site = SiteSetting.first || SiteSetting.new
site.assign_attributes(
  company_name: "Example GmbH",
  company_tagline: "Innovative Lösungen für Ihr Unternehmen",
  hero_title: "Willkommen bei Example GmbH",
  hero_subtitle: "Wir entwickeln maßgeschneiderte Softwarelösungen und beraten Unternehmen bei der digitalen Transformation. Vertrauen Sie auf über 15 Jahre Erfahrung.",
  hero_button_text: "Kontakt aufnehmen",
  hero_button_url: "/contact",
  home_label: "Startseite",
  about_label: "Über uns",
  services_label: "Leistungen",
  blog_label: "Blog",
  contact_label: "Kontakt",
  phone: "+49 30 12345678",
  email: "info@example-gmbh.de",
  website: "https://www.example-gmbh.de",
  street: "Musterstraße 42",
  postal_code: "10115",
  city: "Berlin",
  country: "Deutschland",
  google_maps_url: "https://maps.google.com/?q=Berlin",
  facebook_url: "https://facebook.com/examplegmbh",
  instagram_url: "https://instagram.com/examplegmbh",
  linkedin_url: "https://linkedin.com/company/examplegmbh",
  youtube_url: "https://youtube.com/@examplegmbh",
  primary_color: "#2563eb",
  secondary_color: "#1e40af",
  background_color: "#ffffff",
  text_color: "#1f2937",
  button_color: "#2563eb",
  button_text_color: "#ffffff",
  navbar_background_color: "#ffffff",
  footer_background_color: "#111827",
  site_title: "Example GmbH – Innovative Unternehmenslösungen",
  meta_description: "Example GmbH bietet professionelle Softwareentwicklung, Beratung und IT-Services für Unternehmen in Deutschland.",
  meta_keywords: "Software, Beratung, IT, Berlin, Unternehmen, Digitalisierung",
  og_title: "Example GmbH",
  og_description: "Innovative Lösungen für Ihr Unternehmen",
  show_blog: true,
  show_about: true,
  show_services: true,
  show_contact: true,
  about_content: "Die Example GmbH ist ein führendes Technologieunternehmen mit Sitz in Berlin. Seit 2010 unterstützen wir mittelständische und große Unternehmen bei der digitalen Transformation.\n\nUnser Team aus erfahrenen Entwicklern, Beratern und Projektmanagern arbeitet eng mit unseren Kunden zusammen, um individuelle Lösungen zu entwickeln, die echten Mehrwert schaffen.\n\nWir glauben an Transparenz, Qualität und langfristige Partnerschaften.",
  services_content: "Von der strategischen Beratung bis zur technischen Umsetzung – wir begleiten Sie durch den gesamten Prozess der digitalen Transformation.\n\nUnsere Leistungen umfassen individuelle Softwareentwicklung, Cloud-Migration, DevOps-Automatisierung und kontinuierlichen IT-Support."
)
site.save!
puts "  Site settings: #{site.company_name}"

# Attach placeholder images
attach_remote_image = lambda do |record, attachment_name, url, filename|
  return if record.public_send(attachment_name).attached?

  record.public_send(attachment_name).attach(
    io: URI.open(url),
    filename: filename,
    content_type: "image/jpeg"
  )
rescue StandardError => e
  puts "  Warning: Could not attach #{filename}: #{e.message}"
end

attach_remote_image.call(site, :hero_image, "https://picsum.photos/seed/hero/1600/900", "hero.jpg")
attach_remote_image.call(site, :logo, "https://picsum.photos/seed/logo/200/200", "logo.jpg")
attach_remote_image.call(site, :og_image, "https://picsum.photos/seed/og/1200/630", "og.jpg")

# Blog posts
posts_data = [
  {
    title: "Digitale Transformation im Mittelstand",
    slug: "digitale-transformation-im-mittelstand",
    excerpt: "Wie mittelständische Unternehmen erfolgreich digitale Prozesse einführen und Wettbewerbsvorteile sichern.",
    content: "<p>Die digitale Transformation ist keine Option mehr – sie ist eine Notwendigkeit. Unternehmen, die frühzeitig in digitale Prozesse investieren, sichern sich langfristige Wettbewerbsvorteile.</p><p>In diesem Artikel zeigen wir, wie der Mittelstand Schritt für Schritt digitale Lösungen einführen kann, ohne das Tagesgeschäft zu gefährden.</p>",
    seed: "blog1"
  },
  {
    title: "Cloud-Migration: Best Practices",
    slug: "cloud-migration-best-practices",
    excerpt: "Erfahren Sie, wie Sie Ihre IT-Infrastruktur sicher und effizient in die Cloud verlagern.",
    content: "<p>Die Migration in die Cloud bietet zahlreiche Vorteile: Skalierbarkeit, Kosteneffizienz und verbesserte Sicherheit. Doch ohne sorgfältige Planung können Projekte scheitern.</p><p>Wir teilen unsere bewährten Best Practices aus über 50 erfolgreichen Cloud-Migrationsprojekten.</p>",
    seed: "blog2"
  },
  {
    title: "Agile Entwicklung in Enterprise-Umgebungen",
    slug: "agile-entwicklung-enterprise",
    excerpt: "Agile Methoden sind nicht nur für Startups – auch große Unternehmen profitieren von iterativer Entwicklung.",
    content: "<p>Agile Methoden wie Scrum und Kanban haben die Softwareentwicklung revolutioniert. Doch wie lassen sich diese Ansätze in großen Organisationen mit komplexen Strukturen umsetzen?</p><p>Wir zeigen praxiserprobte Strategien für die Einführung agiler Prozesse im Enterprise-Kontext.</p>",
    seed: "blog3"
  },
  {
    title: "Cybersecurity für KMU",
    slug: "cybersecurity-fuer-kmu",
    excerpt: "Praktische Tipps zum Schutz Ihrer Unternehmensdaten vor Cyberangriffen.",
    content: "<p>Kleine und mittlere Unternehmen sind zunehmend Ziel von Cyberangriffen. Die gute Nachricht: Mit den richtigen Maßnahmen lässt sich das Risiko erheblich reduzieren.</p><p>Von MFA bis Mitarbeiterschulung – hier sind die wichtigsten Schritte für mehr IT-Sicherheit.</p>",
    seed: "blog4"
  },
  {
    title: "KI im Unternehmen: Chancen und Herausforderungen",
    slug: "ki-im-unternehmen",
    excerpt: "Künstliche Intelligenz verändert die Geschäftswelt. Erfahren Sie, wie Sie KI sinnvoll einsetzen.",
    content: "<p>Künstliche Intelligenz ist aus der modernen Wirtschaft nicht mehr wegzudenken. Von Chatbots über Predictive Analytics bis hin zu automatisierten Prozessen – die Einsatzmöglichkeiten sind vielfältig.</p><p>Wir beleuchten Chancen, Risiken und konkrete Anwendungsfälle für den Mittelstand.</p>",
    seed: "blog5"
  }
]

posts_data.each_with_index do |data, index|
  post = Post.find_or_initialize_by(slug: data[:slug])
  post.assign_attributes(
    title: data[:title],
    excerpt: data[:excerpt],
    published: true,
    published_at: (index + 1).weeks.ago
  )
  post.save!
  post.content = data[:content] unless post.content.body.present?
  attach_remote_image.call(post, :cover_image, "https://picsum.photos/seed/#{data[:seed]}/800/500", "#{data[:slug]}.jpg")
  puts "  Post: #{post.title}"
end

# Contact messages
messages_data = [
  { name: "Max Mustermann", email: "max@firma.de", phone: "+49 170 1234567", subject: "Anfrage Softwareentwicklung", message: "Guten Tag, wir suchen einen Partner für die Entwicklung einer individuellen CRM-Lösung. Können Sie uns ein Angebot erstellen?", status: :pending },
  { name: "Anna Schmidt", email: "anna.schmidt@unternehmen.com", phone: nil, subject: "Cloud-Migration Beratung", message: "Wir planen die Migration unserer On-Premise-Infrastruktur in die AWS Cloud. Haben Sie Erfahrung mit solchen Projekten?", status: :pending },
  { name: "Thomas Weber", email: "t.weber@tech-startup.de", phone: "+49 160 9876543", subject: nil, message: "Interessanter Artikel über agile Entwicklung! Wir würden gerne mehr über Ihre Beratungsleistungen erfahren.", status: :read },
  { name: "Lisa Müller", email: "lisa.mueller@handel.de", phone: "+49 30 5551234", subject: "IT-Support Anfrage", message: "Wir benötigen einen zuverlässigen IT-Support-Partner für unsere Filialen. Bitte kontaktieren Sie mich für ein Erstgespräch.", status: :read },
  { name: "Peter Fischer", email: "p.fischer@industrie.de", phone: nil, subject: "Cybersecurity Audit", message: "Nach dem Artikel über Cybersecurity möchten wir ein Sicherheitsaudit für unser Unternehmen durchführen lassen.", status: :archived }
]

messages_data.each do |data|
  msg = ContactMessage.find_or_initialize_by(email: data[:email], name: data[:name])
  msg.assign_attributes(data)
  msg.save!
  puts "  Message: #{data[:name]}"
end

# Custom site page example
careers = SitePage.find_or_initialize_by(slug: "karriere")
careers.assign_attributes(
  label: "Karriere",
  hero_title: "Werden Sie Teil unseres Teams",
  hero_subtitle: "Entdecken Sie spannende Karrieremöglichkeiten bei Example GmbH und gestalten Sie die digitale Zukunft mit.",
  hero_button_text: "Offene Stellen",
  hero_button_url: "/contact",
  main_title: "Arbeiten bei Example GmbH",
  main_subtitle: "Wir bieten ein modernes Arbeitsumfeld, flexible Arbeitszeiten und vielfältige Entwicklungsmöglichkeiten.",
  cta_title: "Bereit für den nächsten Schritt?",
  cta_subtitle: "Senden Sie uns Ihre Bewerbung – wir freuen uns auf Sie.",
  cta_button_text: "Kontakt aufnehmen",
  cta_button_url: "/contact",
  show_cta: true,
  position: 1,
  published: true,
  show_in_nav: true
)
careers.save!
careers.content = "<p>Bei Example GmbH suchen wir talentierte Menschen, die mit Leidenschaft an innovativen Projekten arbeiten.</p><p>Wir bieten ein modernes Arbeitsumfeld, flexible Arbeitszeiten und vielfältige Entwicklungsmöglichkeiten in Berlin und remote.</p>" unless careers.content.body.present?
attach_remote_image.call(careers, :hero_image, "https://picsum.photos/seed/karriere/1600/900", "karriere.jpg")
puts "  Site page: #{careers.label}"

puts "Seeding complete!"
