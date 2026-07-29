# frozen_string_literal: true

module SiteHelper
  def page_title(title = nil)
    base = current_site.site_title.presence || current_site.company_name
    title.present? ? "#{title} | #{base}" : base
  end

  def meta_description
    current_site.meta_description
  end

  def nav_items
    items = [{ label: current_site.home_label, path: root_path, show: true }]
    items << { label: current_site.about_label, path: about_path, show: current_site.show_about? }
    items << { label: current_site.services_label, path: services_path, show: current_site.show_services? }

    SitePage.nav_pages.each do |page|
      items << { label: page.label, path: site_page_path(page), show: true }
    end

    items << { label: current_site.blog_label, path: posts_path, show: current_site.show_blog? }
    items << { label: current_site.contact_label, path: contact_path, show: current_site.show_contact? }
    items.select { |item| item[:show] }
  end

  def active_nav?(path)
    if defined?(@site_page) && @site_page.is_a?(SitePage) && path == site_page_path(@site_page)
      return true
    end

    current_page?(path)
  end

  def page_hero_image_for(page, width: 1600, height: 900)
    if page.hero_image.attached?
      page.hero_image
    else
      placeholder_image_url(width: width, height: height, seed: page.slug)
    end
  end

  def placeholder_image_url(width: 800, height: 600, seed: 1)
    "https://picsum.photos/seed/#{seed}/#{width}/#{height}"
  end

  def cover_image_for(post, width: 800, height: 500)
    if post.cover_image.attached?
      post.cover_image
    else
      placeholder_image_url(width: width, height: height, seed: post.id || post.slug.hash.abs)
    end
  end

  def hero_image_for(site)
    if site.hero_image.attached?
      site.hero_image
    else
      placeholder_image_url(width: 1600, height: 900, seed: "hero")
    end
  end

  def logo_for(site)
    if site.logo.attached?
      site.logo
    else
      nil
    end
  end

  def formatted_address(site)
    parts = [site.street, [site.postal_code, site.city].compact_blank.join(" "), site.country].compact_blank
    parts.join(", ")
  end
end
