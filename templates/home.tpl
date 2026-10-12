{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_video = settings.video_embed %}
{% set has_main_categories = settings.slider_categories and settings.slider_categories is not empty %}
{% set has_banners = settings.banner and settings.banner is not empty %}
{% set has_featured_banner = "featured-banner.jpg" | has_custom_image or "featured-banner-mobile.jpg" | has_custom_image %}
{% set has_promotional_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
{% set has_image_and_text_module = settings.module and settings.module is not empty %}
{% set has_brands = settings.brands and settings.brands is not empty %}
{% set has_banner_products = "banner_products.jpg" | has_custom_image %}
{% set has_informative_banners = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_01_description or settings.banner_services_02_description or settings.banner_services_03_description) %}
{% set has_institutional_message = "institutional-image.jpg" | has_custom_image or settings.banner_home_title or settings.banner_home_description %}
{% set has_welcome_message = settings.welcome_title or settings.welcome_message %}
{% set has_extra_menu = settings.extra_menu_show and settings.extra_menu %}
{% set has_grid_banners = settings.grid_01_show and "grid_01.jpg" | has_custom_image or settings.grid_02_show and "grid_02.jpg" | has_custom_image or settings.grid_03_show and "grid_03.jpg" | has_custom_image or settings.grid_04_show and "grid_04.jpg" | has_custom_image %}
{% set has_instafeed = store.instagram or (settings.instafeed_posts == "instagram" and store.hasInstagramToken()) or (settings.instafeed_posts == "custom" and settings.custom_feed) %}

{% set has_post_01 = settings.post_01_title or settings.post_01_description or "post_01.jpg" | has_custom_image %}
{% set has_post_02 = settings.post_02_title or settings.post_02_description or "post_02.jpg" | has_custom_image %}
{% set has_post_03 = settings.post_03_title or settings.post_03_description or "post_03.jpg" | has_custom_image %}
{% set has_post_04 = settings.post_04_title or settings.post_04_description or "post_04.jpg" | has_custom_image %}
{% set has_blog_posts = has_post_01 or has_post_02 or has_post_03 or has_post_04 %}

{% set has_testimonial_01 = settings.testimonial_01_description or settings.testimonial_01_name or "testimonial_01.jpg" | has_custom_image %}
{% set has_testimonial_02 = settings.testimonial_02_description or settings.testimonial_02_name or "testimonial_02.jpg" | has_custom_image %}
{% set has_testimonial_03 = settings.testimonial_03_description or settings.testimonial_03_name or "testimonial_03.jpg" | has_custom_image %}
{% set has_testimonials = has_testimonial_01 or has_testimonial_02 or has_testimonial_03 %}

{% set faq_total_items = 0 %}
{% for i in 1..10 %}
    {% set index = i < 10 ? '0' ~ i : i %}
    {% set faq_question = attribute(settings, 'faq_item_' ~ index ~ '_question') %}
    {% set faq_answer = attribute(settings, 'faq_item_' ~ index ~ '_answer') %}
    {% if faq_question or faq_answer %}
        {% set faq_total_items = faq_total_items + 1 %}
    {% endif %}
{% endfor %}
{% set has_faq = faq_total_items > 0 %}

{% set show_help = not (has_main_slider or has_mobile_slider or has_video or has_main_categories or has_banners or has_featured_banner or has_promotional_banners or has_image_and_text_module or has_brands or has_banner_products or has_informative_banners or has_institutional_message or has_welcome_message or has_extra_menu or has_grid_banners or has_blog_posts or has_testimonials or has_instafeed or has_faq) and not has_products %}

{% set show_component_help = params.preview %}

{% if show_help or show_component_help %}
    {% include "snipplets/svg/empty-placeholders.tpl" %}
{% endif %}

{% if not params.preview %}
    {% set admin_link = is_theme_draft ? '/admin/themes/settings/draft/' : '/admin/themes/settings/active/' %}
{% endif %}

{% set newArray = [] %}
<div class="js-home-sections-container">
	{% for i in 1..25 %}
        {% set section = 'home_order_position_' ~ i %}
        {% set section_select = attribute(settings, section) %}

        {% if section_select not in newArray %}
            {% include 'snipplets/home/home-section-switch.tpl' %}
            {% set newArray = newArray|merge([section_select]) %}
        {% endif %}
    {% endfor %}

	{#  **** Hidden Sections ****  #}
    {% if show_component_help %}
		<div style="display:none">
			{% for section_select in ['slider', 'informatives', 'main_categories', 'categories', 'promotional', 'grid', 'featured_banner', 'banner_products', 'products', 'new', 'sale', 'promotion', 'best_seller', 'main_product', 'brands', 'testimonials', 'faq', 'video', 'institutional', 'welcome', 'instafeed', 'blog', 'extra_menu', 'newsletter', 'modules'] %}
				{% if section_select not in newArray %}
					{% include 'snipplets/home/home-section-switch.tpl' %}
				{% endif %}
			{% endfor %}
		</div>
	{% endif %}
</div>

{% if (settings.show_news_box and "newsletter_image.jpg" | has_custom_image) or (settings.show_news_box and settings.home_popup_form) %}
	{% include 'snipplets/home/home-popup.tpl' %}
{% endif %}
