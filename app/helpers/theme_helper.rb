# frozen_string_literal: true

module ThemeHelper
  def theme_css_variables(site)
    site.css_variables.map { |key, value| "#{key}: #{value};" }.join("\n  ")
  end

  def theme_style_tag(site)
    tag.style raw("
      :root {
        #{theme_css_variables(site)}
      }
      body {
        background-color: var(--background-color);
        color: var(--text-color);
      }
      .btn-primary {
        background-color: var(--button-color);
        color: var(--button-text-color);
      }
      .btn-primary:hover {
        opacity: 0.9;
      }
      .text-primary { color: var(--primary-color); }
      .bg-primary { background-color: var(--primary-color); }
      .border-primary { border-color: var(--primary-color); }
      .navbar-themed { background-color: var(--navbar-background-color); }
      .footer-themed { background-color: var(--footer-background-color); }
    ")
  end
end
