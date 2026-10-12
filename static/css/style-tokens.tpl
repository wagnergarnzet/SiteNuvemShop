{# /* Style tokens */ #}

:root {

  {#/*============================================================================
    #Colors
  ==============================================================================*/#}

  {#### Colors settings #}

  {# Main colors #}

  {% set primary_color = settings.primary_color %}
  {% set secondary_color = settings.secondary_color %}
  {% set accent_color = settings.accent_color %}

  {% set main_background = settings.background_color %}
  {% set main_foreground = settings.text_color %}

  {% set button_background = settings.add_button_background_color %}
  {% set button_foreground = settings.add_button_foreground_color %}
  
  {% set label_background = settings.label_background_color %}
  {% set label_foreground = settings.label_foreground_color %}

  {# Header colors #}

  {% set header_background = settings.header_colors ? settings.header_background_color : main_background %}
  {% set header_foreground = settings.header_colors ? settings.header_foreground_color : main_foreground %}
  {% set header_icons = settings.header_colors ? settings.header_icons : secondary_color %}

  {% set header_contact_background = settings.header_contact_colors ? settings.header_contact_background_color : header_background %}
  {% set header_contact_foreground = settings.header_contact_colors ? settings.header_contact_foreground_color : header_foreground %}
  {% set header_contact_icons = settings.header_contact_colors ? settings.header_contact_icons : header_icons %}

  {% set adbar_background = settings.adbar_colors ? settings.adbar_background_color : secondary_color %}
  {% set adbar_foreground = settings.adbar_colors ? settings.adbar_foreground_color : main_background %}
  {% set adbar_icon = settings.adbar_colors ? settings.adbar_icon_color : main_background %}

  {% set search_background = settings.search_colors ? settings.search_background_color : main_background %}
  {% set search_foreground = settings.search_colors ? settings.search_foreground_color : main_foreground %}
  {% set search_icon = settings.search_colors ? settings.search_icon_color : secondary_color %}
  {% set search_border = settings.search_colors ? settings.search_border_color %}

  {% set header_badge_background = settings.header_badge_colors ? settings.header_badge_background_color : primary_color %}
  {% set header_badge_foreground = settings.header_badge_colors ? settings.header_badge_foreground_color : main_background %}

  {# Navigation colors #}

  {% set nav_desktop_background = settings.desktop_nav_colors ? settings.desktop_nav_background_color : header_foreground %}
  {% if settings.head_style == "style3" or settings.head_style == "style5" %}
    {% set nav_desktop_foreground = settings.desktop_nav_colors ? settings.desktop_nav_foreground_color : header_foreground %}
  {% else %}
    {% set nav_desktop_foreground = settings.desktop_nav_colors ? settings.desktop_nav_foreground_color : header_background %}
  {% endif %}
  {% set nav_desktop_hover = settings.desktop_nav_colors ? settings.desktop_nav_hover_color : primary_color %}

  {% set header_featured_link_foreground = settings.featured_link_color ? settings.featured_link_foreground_color : header_background %}
  {% set header_featured_link_background = settings.featured_link_color ? settings.featured_link_background_color : accent_color %}

  {% set footer_background = settings.footer_colors ? settings.footer_background_color : main_background %}
  {% set footer_foreground = settings.footer_colors ? settings.footer_foreground_color : main_foreground %}
  {% set footer_titles = settings.footer_colors ? settings.footer_titles_color : main_foreground %}
  {% set footer_icons = settings.footer_colors ? settings.footer_icons_color : main_foreground %}

  {% set footer_form_background = settings.footer_form_colors ? settings.footer_form_background_color : main_background %}
  {% set footer_form_foreground = settings.footer_form_colors ? settings.footer_form_foreground_color : main_foreground %}
  {% set footer_form_titles = settings.footer_form_colors ? settings.footer_form_title_color : main_foreground %}
  {% set footer_form_input_background = settings.footer_form_colors ? settings.footer_form_input_background_color : main_background %}
  {% set footer_form_input_foreground = settings.footer_form_colors ? settings.footer_form_input_foreground_color : main_foreground %}
  {% set footer_form_button_background = settings.footer_form_colors ? settings.footer_form_button_background_color : main_foreground %}
  {% set footer_form_button_foreground = settings.footer_form_colors ? settings.footer_form_button_foreground_color : main_background %}
  {% set footer_social_icons = settings.footer_form_colors ? settings.footer_social_icons_color : main_foreground %}

  {% set nav_mobile_background = settings.mobile_menu_colors ? settings.mobile_menu_background_color : main_background %}
  {% set nav_mobile_foreground = settings.mobile_menu_colors ? settings.mobile_menu_foreground_color : main_foreground %}

  {# Optional colors #}

  {# Home sections colors #}

  {% set slider_background = settings.slider_colors ? settings.slider_background_color : main_background %}
  
  {% set banner_services_background = settings.banner_services_colors ? settings.banner_services_background_color : main_background %}
  {% set banner_services_foreground = settings.banner_services_colors ? settings.banner_services_foreground_color : main_foreground %}
  {% set banner_services_title = settings.banner_services_colors ? settings.banner_services_title_color : secondary_color %}
  {% set banner_services_icon = settings.banner_services_colors ? settings.banner_services_icon_color : secondary_color %}

  {% set main_categories_background = settings.main_categories_colors ? settings.main_categories_background_color : main_background %}
  {% set main_categories_foreground = settings.main_categories_colors ? settings.main_categories_foreground_color : main_foreground %}

  {% set featured_products_background = settings.featured_product_colors ? settings.featured_product_background_color : main_background %}
  {% set featured_products_foreground = settings.featured_product_colors ? settings.featured_product_foreground_color : main_foreground %}

  {% set new_products_background = settings.new_product_colors ? settings.new_product_background_color : main_background %}
  {% set new_products_foreground = settings.new_product_colors ? settings.new_product_foreground_color : main_foreground %}

  {% set sale_products_background = settings.sale_product_colors ? settings.sale_product_background_color : main_background %}
  {% set sale_products_foreground = settings.sale_product_colors ? settings.sale_product_foreground_color : main_foreground %}

  {% set promotion_products_background = settings.promotion_product_colors ? settings.promotion_product_background_color : main_background %}
  {% set promotion_products_foreground = settings.promotion_product_colors ? settings.promotion_product_foreground_color : main_foreground %}

  {% set best_seller_products_background = settings.best_seller_product_colors ? settings.best_seller_product_background_color : main_background %}
  {% set best_seller_products_foreground = settings.best_seller_product_colors ? settings.best_seller_product_foreground_color : main_foreground %}

  {% set banner_products_background = settings.banner_product_colors ? settings.banner_product_background_color : main_background %}
  {% set banner_products_foreground = settings.banner_product_colors ? settings.banner_product_foreground_color : main_foreground %}
  {% set banner_products_content = settings.banner_product_colors ? settings.banner_product_content_background_color : main_background %}

  {% set main_product_background = settings.main_product_colors ? settings.main_product_background_color : main_background %}
  {% set main_product_foreground = settings.main_product_colors ? settings.main_product_foreground_color : main_foreground %}

  {% set categories_background = settings.banner_colors ? settings.categories_background_color : main_background %}
  {% set categories_foreground = settings.banner_colors ? settings.categories_foreground_color : main_foreground %}

  {% set featured_banner_background = settings.featured_banner_colors ? settings.featured_banner_background_color : main_background %}

  {% set banner_promotional_background = settings.banner_promotional_colors ? settings.banner_promotional_background_color : main_background %}
  {% set banner_promotional_foreground = settings.banner_promotional_colors ? settings.banner_promotional_foreground_color : main_foreground %}
  {% set banner_promotional_overlay = settings.banner_promotional_colors ? settings.banner_promotional_overlay_color : accent_color %}

  {% set banner_featured_background = settings.featured_banner_colors ? settings.featured_banner_background_color : main_background %}

  {% set banner_grid_background = settings.banner_grid_colors ? settings.banner_grid_background_color : main_background %}
  {% set banner_grid_foreground = settings.banner_grid_colors ? settings.banner_grid_foreground_color : main_foreground %}

  {% set blog_background = settings.blog_colors ? settings.blog_background_color : main_background %}
  {% set blog_foreground = settings.blog_colors ? settings.blog_foreground_color : main_foreground %}

  {% set institutional_background = settings.institutional_colors ? settings.institutional_background_color : main_background %}
  {% set institutional_foreground = settings.institutional_colors ? settings.institutional_foreground_color : main_foreground %}

  {% set brands_background = settings.brands_colors ? settings.brands_background_color : main_background %}
  {% set brands_foreground = settings.brands_colors ? settings.brands_foreground_color : main_foreground %}

  {% set testimonials_background = settings.testimonials_colors ? settings.testimonials_background_color : main_background %}
  {% set testimonials_foreground = settings.testimonials_colors ? settings.testimonials_foreground_color : main_foreground %}
  {% set testimonials_titles = settings.testimonials_colors ? settings.testimonials_titles_color : main_foreground %}
  {% set testimonials_block = settings.testimonials_colors ? settings.testimonials_block_color : main_background %}

  {% set faq_background = settings.faq_colors ? settings.faq_background_color : main_background %}
  {% set faq_foreground = settings.faq_colors ? settings.faq_foreground_color : main_foreground %}

  {% set newsletter_background = settings.newsletter_colors ? settings.newsletter_background_color : accent_color %}
  {% set newsletter_foreground = settings.newsletter_colors ? settings.newsletter_foreground_color : main_background %}
  {% set newsletter_button_background = settings.newsletter_colors ? settings.newsletter_button_background_color : main_background %}
  {% set newsletter_button_foreground = settings.newsletter_colors ? settings.newsletter_button_foreground_color : main_foreground %}

  {% set welcome_background = settings.welcome_colors ? settings.welcome_background_color : '' %}
  {% set welcome_foreground = settings.welcome_colors ? settings.welcome_foreground_color : '' %}

  {% set instafeed_background = settings.instafeed_colors ? settings.instafeed_background_color : main_foreground %}
  {% set instafeed_foreground = settings.instafeed_colors ? settings.instafeed_foreground_color : main_background %}

  {% set extra_menu_background = settings.extra_menu_colors ? settings.extra_menu_background_color : main_background %}
  {% set extra_menu_foreground = settings.extra_menu_colors ? settings.extra_menu_foreground_color : main_foreground %}

  {% set custom_section_1_background = settings.custom_page_section_1_colors ? settings.custom_page_section_1_background_color : main_background %}
  {% set custom_section_2_background = settings.custom_page_section_2_colors ? settings.custom_page_section_2_background_color : main_background %}  
  {% set custom_section_3_background = settings.custom_page_section_3_colors ? settings.custom_page_section_3_background_color : main_background %}
  {% set custom_section_4_background = settings.custom_page_section_4_colors ? settings.custom_page_section_4_background_color : main_background %}
  {% set custom_section_5_background = settings.custom_page_section_5_colors ? settings.custom_page_section_5_background_color : main_background %}

  {% set custom_section_1_foreground = settings.custom_page_section_1_colors ? settings.custom_page_section_1_foreground_color : main_foreground %}
  {% set custom_section_2_foreground = settings.custom_page_section_2_colors ? settings.custom_page_section_2_foreground_color : main_foreground %}  
  {% set custom_section_3_foreground = settings.custom_page_section_3_colors ? settings.custom_page_section_3_foreground_color : main_foreground %}
  {% set custom_section_4_foreground = settings.custom_page_section_4_colors ? settings.custom_page_section_4_foreground_color : main_foreground %}
  {% set custom_section_5_foreground = settings.custom_page_section_5_colors ? settings.custom_page_section_5_foreground_color : main_foreground %}

  {% set video_foreground = settings.video_color %}

  {#### CSS Colors #}

  {# Main colors #}

  --main-foreground: {{ main_foreground }};
  --main-background: {{ main_background }};

  --primary-color: {{ primary_color }};
  --secondary-color: {{ secondary_color }};
  --accent-color: {{ accent_color }};

  --button-background: {{ button_background }};
  --button-foreground: {{ button_foreground }};

  --label-background: {{ label_background }};
  --label-foreground: {{ label_foreground }};

  {# Optional colors #}

  {# Header colors #}

  --adbar-background: {{ adbar_background }};
  --adbar-foreground: {{ adbar_foreground }};
  --adbar-icon: {{ adbar_icon }};

  --header-badge-background: {{ header_badge_background }};
  --header-badge-foreground: {{ header_badge_foreground }};

  --nav-desktop-foreground: {{ nav_desktop_foreground }};
  
  --nav-desktop-background: {{ nav_desktop_background }};
  --nav-desktop-hover: {{ nav_desktop_hover }};

  --header-featured-link-foreground: {{ header_featured_link_foreground }};
  --header-featured-link-background: {{ header_featured_link_background }};

  --topbar-background: {{ header_contact_background }};
  --topbar-foreground: {{ header_contact_foreground }};
  --topbar-icons: {{ header_contact_icons }};

  --search-background: {{ search_background }};
  --search-foreground: {{ search_foreground }};
  --search-icon: {{ search_icon }};

  --nav-mobile-background: {{ nav_mobile_background }};
  --nav-mobile-foreground: {{ nav_mobile_foreground }};

  {# Footer colors #}

  --footer-background: {{ footer_background }};
  --footer-foreground: {{ footer_foreground }};
  --footer-titles: {{ footer_titles }};
  --footer-icons: {{ footer_icons }};
  --footer-form-background: {{ footer_form_background }};
  --footer-form-foreground: {{ footer_form_foreground }};
  --footer-form-input-background: {{ footer_form_input_background }};
  --footer-form-input-foreground: {{ footer_form_input_foreground }};
  --footer-form-titles: {{ footer_form_titles }};
  --footer-form-button-background: {{ footer_form_button_background }};
  --footer-form-button-foreground: {{ footer_form_button_foreground }};
  --footer-social-icons: {{ footer_social_icons }};

  {# Home sections colors #}

  --slider-background: {{ slider_background }};

  --main-categories-background: {{ main_categories_background }};
  --main-categories-foreground: {{ main_categories_foreground }};

  --featured-background: {{ featured_products_background }};
  --featured-foreground: {{ featured_products_foreground }};

  --new-background: {{ new_products_background }};
  --new-foreground: {{ new_products_foreground }};

  --sale-background: {{ sale_products_background }};
  --sale-foreground: {{ sale_products_foreground }};

  --promotion-background: {{ promotion_products_background }};
  --promotion-foreground: {{ promotion_products_foreground }};

  --best-seller-background: {{ best_seller_products_background }};
  --best-seller-foreground: {{ best_seller_products_foreground }};

  --banner-products-background: {{ banner_products_background }};
  --banner-products-foreground: {{ banner_products_foreground }};
  --banner-products-content: {{ banner_products_content }};

  --newsletter-background: {{ newsletter_background }};
  --newsletter-foreground: {{ newsletter_foreground }};
  --newsletter-button: {{ newsletter_button_background }};
  --newsletter-button-text: {{ newsletter_button_foreground }};

  --welcome-background: {{ welcome_background }};
  --welcome-foreground: {{ welcome_foreground }};

  --testimonials-background: {{ testimonials_background }};
  --testimonials-titles: {{ testimonials_titles }};
  --testimonials-foreground: {{ testimonials_foreground }};
  --faq-background: {{ faq_background }};
  --faq-foreground: {{ faq_foreground }};

  --institutional-background: {{ institutional_background }};
  --institutional-foreground: {{ institutional_foreground }};

  --categories-background: {{ categories_background }};
  --categories-foreground: {{ categories_foreground }};

  --gridbanners-background: {{ banner_grid_background }};
  --gridbanners-foreground: {{ banner_grid_foreground }};

  --brands-background: {{ brands_background }};
  --brands-foreground: {{ brands_foreground }};

  --featured-banner-background: {{ featured_banner_background }};

  --video-foreground: {{ video_foreground }};

  --banner-services-background: {{ banner_services_background }};
  --banner-services-foreground: {{ banner_services_foreground }};
  --banner-services-title: {{ banner_services_title }};
  --banner-services-icon: {{ banner_services_icon }};
  --banner-services-width: {{ settings.container_width == "full" ? '100%' : '1200px' }};

  --instafeed-background: {{ instafeed_background }};
  --instafeed-foreground: {{ instafeed_foreground }};

  --extra-menu-background: {{ extra_menu_background }};
  --extra-menu-foreground: {{ extra_menu_foreground }};

  --blog-background: {{ blog_background }};
  --blog-foreground: {{ blog_foreground }};

  {% if setings.extra_menu_size == "medium" %}
    --extra-menu-size: 14px;
    --extra-menu-padding: 15px; 
    --extra-menu-min: 50px;
  {% elseif settings.extra_menu_size == "large" %}
    --extra-menu-size: 15px;
    --extra-menu-padding: 20px;
    --extra-menu-min: 60px; 
  {% else %}
    --extra-menu-size: 13px;
    --extra-menu-padding: 10px; 
    --extra-menu-min: 40px;
  {% endif %}

  --extra-menu-gap: {{ settings.extra_menu_gap }}px;

  {# Color shades #}

  {# Opacity hex levels #}

  {% set opacity_03 = '08' %}
  {% set opacity_05 = '0D' %}
  {% set opacity_08 = '14' %}
  {% set opacity_10 = '1A' %}
  {% set opacity_15 = '26' %}
  {% set opacity_20 = '33' %}
  {% set opacity_30 = '4D' %}
  {% set opacity_40 = '66' %}
  {% set opacity_45 = '73' %}
  {% set opacity_50 = '80' %}
  {% set opacity_60 = '99' %}
  {% set opacity_70 = 'B3' %}
  {% set opacity_75 = 'BF' %}
  {% set opacity_80 = 'CC' %}
  {% set opacity_90 = 'E6' %}
  {% set opacity_95 = 'F2' %}

  --main-foreground-opacity-03: {{ main_foreground }}{{ opacity_03 }};
  --main-foreground-opacity-05: {{ main_foreground }}{{ opacity_05 }};
  --main-foreground-opacity-08: {{ main_foreground }}{{ opacity_08 }};
  --main-foreground-opacity-10: {{ main_foreground }}{{ opacity_10 }};
  --main-foreground-opacity-20: {{ main_foreground }}{{ opacity_20 }};
  --main-foreground-opacity-30: {{ main_foreground }}{{ opacity_30 }};
  --main-foreground-opacity-40: {{ main_foreground }}{{ opacity_40 }};
  --main-foreground-opacity-50: {{ main_foreground }}{{ opacity_50 }};
  --main-foreground-opacity-60: {{ main_foreground }}{{ opacity_60 }};
  --main-foreground-opacity-70: {{ main_foreground }}{{ opacity_70 }};
  --main-foreground-opacity-80: {{ main_foreground }}{{ opacity_80 }};

  --main-background-opacity-30: {{ main_background }}{{ opacity_30 }};
  --main-background-opacity-40: {{ main_background }}{{ opacity_40 }};
  --main-background-opacity-50: {{ main_background }}{{ opacity_50 }};
  --main-background-opacity-80: {{ main_background }}{{ opacity_80 }};
  --main-background-opacity-90: {{ main_background }}{{ opacity_90 }};

  --header-desktop-background: {{ header_background }};
  --header-desktop-background-opacity: {{ header_background }}{{ opacity_05 }};
  --header-desktop-foreground: {{ header_foreground }};
  --header-icons: {{ header_icons }};

  --header-foreground-opacity-10: {{ header_foreground }}{{ opacity_10 }};
  --header-foreground-opacity-20: {{ header_foreground }}{{ opacity_20 }};
  --header-foreground-opacity-50: {{ header_foreground }}{{ opacity_50 }};

  --nav-desktop-foreground-opacity-05: {{ nav_desktop_foreground }}{{ opacity_05 }};
  --nav-desktop-foreground-opacity-10: {{ nav_desktop_foreground }}{{ opacity_10 }};
  --nav-desktop-foreground-opacity-60: {{ nav_desktop_foreground }}{{ opacity_60 }};

  --nav-mobile-foreground-opacity-05: {{ nav_mobile_foreground }}{{ opacity_05 }};
  --nav-mobile-foreground-opacity-10: {{ nav_mobile_foreground }}{{ opacity_10 }};
  --nav-mobile-foreground-opacity-20: {{ nav_mobile_foreground }}{{ opacity_20 }};
  --nav-mobile-foreground-opacity-30: {{ nav_mobile_foreground }}{{ opacity_30 }};
  --nav-mobile-foreground-opacity-40: {{ nav_mobile_foreground }}{{ opacity_40 }};

  {% if settings.head_style == "style3" or settings.head_style == "style5" %}
    --nav-item-spacing: 0;
  {% else %}
    --nav-item-spacing: 10px;
  {% endif %}

  --header-badge-foreground-opacity-20: {{ header_badge_foreground }}{{ opacity_20 }};

  --adbar-foreground-opacity-10: {{ addbar_foreground }}{{ opacity_10 }};

  {% if settings.header_contact_line %}
    --topbar-border: 1px solid {{ main_foreground }}{{ opacity_05 }};
  {% else %}
    --topbar-border: none;
  {% endif %}

  --search-foreground-opacity-50: {{ search_foreground }}{{ opacity_50 }};

  {% if settings.search_colors %}
    --search-border: {{ search_border }};
  {% else %}
    --search-border: {{ main_foreground }}{{ opacity_30 }};
  {% endif %}

  --main-categories-foreground-opacity-20: {{ main_categories_foreground }}{{ opacity_20 }};

  --brands-foreground-opacity-10: {{ brands_foreground }}{{ opacity_10 }};

  --welcome-foreground-opacity-90: {{ welcome_foreground }}{{ opacity_90 }};

  --institutional-foreground-opacity-30: {{ institutional_foreground }}{{ opacity_30 }};

  {% if settings.institutional_overlay %}
    --institutional-opacity: {{ settings.institutional_overlay_opacity }};
  {% else %}
    --institutional-opacity: 0.2;
  {% endif %}

  {% if settings.testimonials_colors %}
    --testimonials-block: {{ testimonials_block }};
  {% else %}
    --testimonials-block: {{ main_background }};
  {% endif %}


  --news-foreground-opacity-10: {{ newsletter_foreground }}{{ opacity_10 }};
  --news-foreground-opacity-30: {{ newsletter_foreground }}{{ opacity_30 }};
  --news-foreground-opacity-50: {{ newsletter_foreground }}{{ opacity_50 }};
  --news-foreground-opacity-70: {{ newsletter_foreground }}{{ opacity_70 }};

  --footer-foreground-opacity-10: {{ footer_foreground }}{{ opacity_10 }};
  --footer-foreground-opacity-20: {{ footer_foreground }}{{ opacity_20 }};
  --footer-foreground-opacity-50: {{ footer_foreground }}{{ opacity_50 }};
  --footer-foreground-opacity-60: {{ footer_foreground }}{{ opacity_60 }};
  --footer-foreground-opacity-80: {{ footer_foreground }}{{ opacity_80 }};

  --footer-form-input-foreground-opacity-50: {{ footer_form_input_foreground }}{{ opacity_50 }};

  {% if settings.banner_promotional_overlay_opacity == 15 %}
    {% set promotional_opacity = '26' %}
  {% elseif settings.banner_promotional_overlay_opacity == 30 %}
    {% set promotional_opacity = '4D' %}
  {% elseif settings.banner_promotional_overlay_opacity == 45 %}
    {% set promotional_opacity = '73' %}
  {% elseif settings.banner_promotional_overlay_opacity == 60 %}
    {% set promotional_opacity = '99' %}
  {% elseif settings.banner_promotional_overlay_opacity == 75 %}
    {% set promotional_opacity = 'BF' %}
  {% elseif settings.banner_promotional_overlay_opacity == 90 %}
    {% set promotional_opacity = 'E6' %}
  {% else %}
    {% set promotional_opacity = '00' %}
  {% endif %}

  --banner-promotional-background: {{ banner_promotional_background }};
  --banner-promotional-foreground: {{ banner_promotional_foreground }};
  --banner-promotional-overlay: {{ banner_promotional_overlay }}{{ promotional_opacity }};

  --extra-menu-foreground-opacity-10: {{ extra_menu_foreground }}{{ opacity_10 }};

  {# Custom page section colors #}
  
  --custom-section-1-background: {{ custom_section_1_background }};
  --custom-section-2-background: {{ custom_section_2_background }};
  --custom-section-3-background: {{ custom_section_3_background }};
  --custom-section-4-background: {{ custom_section_4_background }};
  --custom-section-5-background: {{ custom_section_5_background }};

  --custom-section-1-foreground: {{ custom_section_1_foreground }};
  --custom-section-2-foreground: {{ custom_section_2_foreground }};
  --custom-section-3-foreground: {{ custom_section_3_foreground }};
  --custom-section-4-foreground: {{ custom_section_4_foreground }};
  --custom-section-5-foreground: {{ custom_section_5_foreground }};

  --custom-section-1-button-background: {{ settings.custom_page_section_1_button_background_color }};
  --custom-section-1-button-foreground: {{ settings.custom_page_section_1_button_foreground_color }};
  --custom-section-2-button-background: {{ settings.custom_page_section_2_button_background_color }};
  --custom-section-2-button-foreground: {{ settings.custom_page_section_2_button_foreground_color }};
  --custom-section-3-button-background: {{ settings.custom_page_section_3_button_background_color }};
  --custom-section-3-button-foreground: {{ settings.custom_page_section_3_button_foreground_color }};
  --custom-section-4-button-background: {{ settings.custom_page_section_4_button_background_color }};
  --custom-section-4-button-foreground: {{ settings.custom_page_section_4_button_foreground_color }};
  --custom-section-5-button-background: {{ settings.custom_page_section_5_button_background_color }};
  --custom-section-5-button-foreground: {{ settings.custom_page_section_5_button_foreground_color }};

  {# Alert colors CSS #}

  --success: #4bb98c;
  --danger: #dd7774;
  --warning: #dc8f38;

  {#/*============================================================================
    #Fonts
  ==============================================================================*/#}

  {# Font families #}

  --heading-font: {{ settings.font_headings | raw }};
  --menu-font: {{ settings.font_menu | raw }};
  --body-font: {{ settings.font_rest | raw }};

  {# Font sizes #}

  --h1: 1.75rem;
  --h1-huge: 1.875rem;
  --h1-huge-md: 2.5rem;
  --h2: 1.75rem;
  --h3: 1.25rem;
  --h4: 1.125rem;
  --h5: 1rem;
  --h6: 0.875rem;
 
  --font-big: 1rem;
  --font-base: 0.875rem;
  --font-small: 0.75rem;
  --font-smallest: 0.625rem;

  --font-11: 0.6875rem;
  --font-12: 0.75rem;
  --font-13: 0.8125rem;
  --font-14: 0.875rem;
  --font-15: 0.9375rem;
  --font-16: 1rem;
  --font-18: 1.125rem;
  --font-20: 1.25rem;
  --font-22: 1.375rem;
  --font-24: 1.5rem;
  --font-26: 1.625rem;
  --font-28: 1.75rem;
  --font-30: 1.875rem;
  --font-32: 2rem;
  --font-36: 2.25rem;
  --font-40: 2.5rem;
  --font-44: 2.75rem;
  --font-48: 3rem;

  {% if settings.font_menus_size %}
    --font-menu: var(--font-{{ settings.font_menus_size }});
  {% else %}
    --font-menu: var(--font-14);
  {% endif %}

  {% if settings.font_headings_size %}
    --font-headings: var(--font-{{ settings.font_headings_size }});
  {% else %}
    --font-headings: var(--font-24);
  {% endif %}

  {% if settings.font_rest_size %}
    --font-rest: var(--font-{{ settings.font_rest_size }});
  {% else %}
    --font-rest: var(--font-14);
  {% endif %}
  
  {# Font weights #}

  --font-weight-light: 300;
  --font-weight-regular: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;

  {# Font styles #}

  --font-style-normal: normal;
  --font-style-italic: italic;

  {% if settings.font_headings_weight[:3] == '300' %}
    --font-headings-weight: var(--font-weight-light);
  {% elseif settings.font_headings_weight[:3] == '400' %}
    --font-headings-weight: var(--font-weight-regular);
  {% elseif settings.font_headings_weight[:3] == '500' %}
    --font-headings-weight: var(--font-weight-medium);
  {% elseif settings.font_headings_weight[:3] == '600' %}
    --font-headings-weight: var(--font-weight-semibold);
  {% elseif settings.font_headings_weight[:3] == '700' %}
    --font-headings-weight: var(--font-weight-bold);
  {% endif %}

  {% if settings.font_headings_weight[3:] == 'italic' %}
    --font-headings-style: var(--font-style-italic);
  {% else %}
    --font-headings-style: var(--font-style-normal);
  {% endif %}

  {% if settings.font_menu_weight[:3] == '300' %}
    --font-menu-weight: var(--font-weight-light);
  {% elseif settings.font_menu_weight[:3] == '400' %}
    --font-menu-weight: var(--font-weight-regular);
  {% elseif settings.font_menu_weight[:3] == '500' %}
    --font-menu-weight: var(--font-weight-medium);
  {% elseif settings.font_menu_weight[:3] == '600' %}
    --font-menu-weight: var(--font-weight-semibold);
  {% elseif settings.font_menu_weight[:3] == '700' %}
    --font-menu-weight: var(--font-weight-bold);
  {% endif %}

  {% if settings.font_menu_weight[3:] == 'italic' %}
    --font-menu-style: var(--font-style-italic);
  {% else %}
    --font-headings-style: var(--font-style-normal);    
  {% endif %}

  {# Font transform #}
  {% if settings.menu_uppercase %}
    --font-menu-transform: uppercase;
  {% else %}
    --font-menu-transform: none;
  {% endif %}

  {# Font spacing #}

  {#/*============================================================================
    #Spacing
  ==============================================================================*/#}

  {# Gutters #}

  --gutter: 15px;
  --gutter-container: 15px;
  --gutter-container-md: 80px;
  --gutter-negative: calc(var(--gutter) * -1);
  --gutter-half: calc(var(--gutter) / 2);
  --gutter-half-negative: calc(var(--gutter) * -1 / 2);
  --gutter-double: calc(var(--gutter) * 2);

  {#/*============================================================================
    #Misc
  ==============================================================================*/#}

  {# Borders #}

  --border-radius-none : 0px;
  --border-radius-full: 100%;
  --border-radius-30: 30px;
  --border-radius-half: calc(var(--border-radius) / 2);
  --border-radius-quarter: calc(var(--border-radius) / 4);
  --border-solid: 1px solid;
  --border-dashed: 1px dashed;

  {% if settings.theme_round == "none" or settings.theme_round == "min" %}
    --border-radius-item-image: 0;
  {% else %}
    {% if settings.item_borders %}
      {% if settings.item_borders %}
        --border-radius-item-image: 0;
      {% else %}
        --border-radius-item-image: 4px;
      {% endif %}
    {% else %}
      --border-radius-item-image: 14px;
    {% endif %}
  {% endif %}

  --btn-border-radius: var(--border-radius);

  {% if settings.theme_round == "max" %}
    --border-radius: 8px;
  {% elseif settings.theme_round == "med" %}
    --border-radius: 6px;
  {% else %}
    --border-radius: 4px;
  {% endif %}

  {# Theme Round #}

  {% if settings.theme_round == "max" %}
    --theme-round-full: 30px;
    --theme-round: var(--border-radius);
  {% elseif settings.theme_round == "none" %}
    --theme-round-full: var(--border-radius-none);
    --theme-round: var(--border-radius-none);
  {% else %}
    --theme-round-full: var(--border-radius);
    --theme-round: var(--border-radius);
  {% endif %}

  {# Shadows #}

  --shadow-distance: 0 0 5px;

  {# Columns #}

  {% if template == "category" and (filter_categories is not empty or product_filters is not empty) %}
    --column-custom: 25%;
  {% else %}
    --column-custom: 20%;
  {% endif %}

  {# Sections #}

  {% if settings.home_section_distance %}
    --section-distance: {{ settings.home_section_distance }}px;
  {% else %}
    --section-distance: 40px;
  {% endif %}
  --section-negative-distance: calc(var(--section-distance) * -1);

  {# Popup Modal #}

  {% if settings.home_popup_form and "newsletter_image.jpg" | has_custom_image %}
    --popup-width: 720px;
  {% elseif "newsletter_image.jpg" | has_custom_image %}
    --popup-width: 500px;
  {% else %}
    --popup-width: fit-content;
  {% endif %}

  {# Banner services #}

  {% if settings.banner_services_icon_size_desktop %}
    --banner-services-icon-size-desktop: {{ settings.banner_services_icon_size_desktop }}px;
  {% else %}
    --banner-services-icon-size-desktop: 42px;
  {% endif %}
  {% if settings.banner_services_icon_size_mobile %}
    --banner-services-icon-size-mobile: {{ settings.banner_services_icon_size_mobile }}px;
  {% else %}
    --banner-services-icon-size-mobile: 42px;
  {% endif %}

  {# Item #}

  {% if settings.item_colors %}
    --item-background: {{ settings.item_background_color }};
  {% else %}
    --item-background: {{ main_background }};
  {% endif %}

  {% if settings.item_name_size == "medium" %}
    --item-name-size: 14px;
  {% elseif settings.item_name_size == "large" %}
    --item-name-size: 15px;
  {% else %}
    --item-name-size: 13px;
  {% endif %}

  {% if settings.item_name_lines %}
    --item-name-lines: {{ settings.item_name_lines }};
  {% else %}
    --item-name-lines: 2;
  {% endif %}

  {% if settings.item_brand and product.brand %}
    --item-name-wrapper: calc(var(--item-name-size) * var(--item-name-lines) + 10px + var(--font-small));
  {% else %}
    --item-name-wrapper: calc(var(--item-name-size) * var(--item-name-lines) + 10px);
  {% endif %}

  {% if settings.item_price_size == "medium" %}
    --item-price-size: 13px;
  {% elseif settings.item_price_size == "large" %}
    --item-price-size: 14px;
  {% else %}
    --item-price-size: 12px;
  {% endif %}

  --item-price-color: {{ settings.item_price_color ? settings.item_price_foreground_color : main_text }};
  --item-payment-discount-price-color: {{ settings.item_payment_discount_price_color ? settings.item_payment_discount_price_foreground_color : 'inherit' }};

  {# Item height #}

  {% if settings.product_size_variants %}
    {% set item_size_height = ' + 23px' %}
  {% endif %}

  {% if settings.product_color_variants %}
    {% set item_color_height = ' + 23px' %}
  {% endif %}

  {% if settings.item_brand %}
    {% set item_brand_height = ' + 23px' %}
  {% endif %}

  {% if settings.item_same_height %}
    --item-container-height: calc(var(--item-name-container){{ item_size_height }}{{ item_color_height }}{{ item_brand_height }}{{ item_categories_height }}{{ item_price_height }}{{ item_buttons_height }});
  {% else %}
    --item-container-height: initial;
  {% endif %}

  --item-name-container: calc((var(--item-name-size) * var(--item-name-lines) + 18px){{ item_size_height }}{{ item_color_height }}{{ item_brand_height }});

  {% if settings.show_installments %}
    {% set item_installments = ' + 18px' %}
  {% endif %}

  {% if settings.item_unity_price %}
    {% set item_price_height = ' + 22px' %}
  {% endif %}

  {% if settings.item_same_height %}
    --item-price-container: calc(var(--item-price-size)*1.5{{ item_installments }}{{ item_price_height }} + 20px);
  {% else %}
    --item-price-container: initial;
  {% endif %}

  {# Item colors #}

  --item-bullet-border: {{ settings.item_colors_on_image == "image" ? 'var(--main-background)' : 'var(--main-foreground-opacity-30)' }};

  {# Product detail #}

  --product-price-color: {{ settings.product_price_color ? settings.product_price_foreground_color : main_text }};
  --product-payment-discount-price-color: {{ settings.product_payment_discount_price_color ? settings.product_payment_discount_price_foreground_color : 'var(--item-payment-discount-price-color)' }};

  {% if settings.product_featured_price_size == "small" %}
    --product-featured-price-size: 1.5rem;
  {% elseif settings.product_featured_price_size == "large" %}
    --product-featured-price-size: 2.5rem;
  {% else %}
    --product-featured-price-size: 1.8rem;
  {% endif %}

  {# Instafeed #}

  {% if settings.instafeed_size == 'small' %}
    --instafeed-font-size: {{ settings.instafeed_size }};
  {% elseif settings.instafeed_size == 'medium' %}
    --instafeed-font-size: var(--font-20);
  {% else %}
    --instafeed-font-size: var(--font-24);
  {% endif %}

  {% if settings.search_position == 'menu' %}
    --search-mobile-padding: 15px 15px 0;
  {% else %}
    --search-mobile-padding: 0 15px 15px;
  {% endif %}

  {# Container width #}

  {% if settings.container_width == "full" %}
    --container-width-sm: 100%;
    --container-width-md: 100%;
    --container-width-lg: 100%;
    --container-width-xl: calc(100% - 50px);
    --container-width: calc(100% - 50px);
    --container-width-max: calc(100% - 50px);
  {% else %}
    --container-width-sm: 540px;
    --container-width-md: 720px;
    --container-width-lg: 960px;
    --container-width-xl: 1140px;
    --container-width: 1200px;
    --container-width-max: 1300px;
  {% endif %}

  {# Header background #}
  --header-background-image: none;
  --header-background-repeat: no-repeat;
  --header-background-size: auto;
  --header-background-image-mobile: none;
  --header-background-repeat-mobile: no-repeat;
  --header-background-size-mobile: auto;
  --header-contact-bar-background: var(--topbar-background);
  --header-contact-bar-background-mobile: var(--topbar-background);

  {% if settings.head_background and 'head_background.jpg' | has_custom_image %}
    --header-background-image: url('{{ 'head_background.jpg' | static_url | settings_image_url('1080p') }}');
    --header-contact-bar-background: transparent;
  {% endif %}
  {% if settings.head_background %}
    --header-background-repeat: {{ settings.head_background_repeat }};
    --header-background-size: {{ settings.head_background_size }};
  {% endif %}
  {% if settings.head_background_mobile and 'head_background_mobile.jpg' | has_custom_image %}
    --header-background-image-mobile: url('{{ 'head_background_mobile.jpg' | static_url | settings_image_url('480w') }}');
    --header-contact-bar-background-mobile: transparent;
  {% endif %}
  {% if settings.head_background_mobile %}
    --header-background-repeat-mobile: {{ settings.head_background_repeat_mobile }};
    --header-background-size-mobile: {{ settings.head_background_size_mobile }};
  {% endif %}

  {# Footer background #}
  {% if settings.footer_background %}
    --footer-background-repeat: {{ settings.footer_background_repeat }};
    --footer-background-size: {{ settings.footer_background_size }};
  {% endif %}
  {% if settings.footer_background_mobile %}
    --footer-background-repeat-mobile: {{ settings.footer_background_repeat_mobile }};
    --footer-background-size-mobile: {{ settings.footer_background_size_mobile }};
  {% endif %}

}

{# // Media query - Min width 768px #}

@media (min-width: 768px) {
  :root {

    {# Item name size #}

    {% if settings.item_name_size == "medium" %}
      --item-name-size: 16px;
    {% elseif settings.item_name_size == "large" %}
      --item-name-size: 18px;
    {% else %}
      --item-name-size: 14px;
    {% endif %}

    {# Item price size #}

    {% if settings.item_price_size == "medium" %}
      --item-price-size: 14px;
    {% elseif settings.item_price_size == "large" %}
      --item-price-size: 16px;
    {% else %}
      --item-price-size: 12px;
    {% endif %}
    
  }
}
