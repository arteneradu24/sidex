# frozen_string_literal: true

module ControlpanelHelper
  def controlpanel_nav_items
    [
      { label: "Dashboard", path: controlpanel_root_path, icon: "dashboard" },
      { label: "General", path: edit_controlpanel_general_settings_path, icon: "settings" },
      { label: "Appearance", path: edit_controlpanel_appearance_settings_path, icon: "palette" },
      { label: "Contact", path: edit_controlpanel_contact_settings_path, icon: "contact" },
      { label: "Blog", path: controlpanel_posts_path, icon: "blog" },
      { label: "Messages", path: controlpanel_contact_messages_path, icon: "mail" },
      { label: "SEO", path: edit_controlpanel_seo_settings_path, icon: "seo" },
      { label: "Media", path: controlpanel_media_path, icon: "media" }
    ]
  end

  def cp_nav_active?(path)
    current_page?(path) || (path != controlpanel_root_path && request.path.start_with?(path))
  end

  def status_badge(status)
    colors = {
      "pending" => "bg-blue-100 text-blue-800",
      "read" => "bg-green-100 text-green-800",
      "archived" => "bg-gray-100 text-gray-600"
    }
    label = status.to_s == "pending" ? "New" : status.to_s.humanize
    tag.span label, class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium #{colors[status.to_s]}"
  end

  def publish_badge(published)
    if published
      tag.span "Published", class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
    else
      tag.span "Draft", class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800"
    end
  end
end
