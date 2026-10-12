{% if section_select == 'slider' %}

    {#  **** Home slider ****  #}

    <section class="section-slider {% if settings.slider_distance %}slider-distance{% endif %} {% if settings.slider_distance_mobile %}slider-distance-mobile{% endif %} {{ settings.slider_colors ? 'section-home-color' }}" data-store="home-slider">
        {% if show_help or (show_component_help and not (has_main_slider or has_mobile_slider)) %}
            {% snipplet 'defaults/home/slider_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-slider.tpl' %}
            {% if has_mobile_slider %}
                {% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
            {% endif %}
        {% endif %}
    </section>

{% elseif section_select == 'informatives' %}

    {#  **** Informative banners ****  #}
    {% if show_help or (show_component_help and not has_informative_banners) %}
        {% snipplet 'defaults/home/informative_banners_help.tpl' %}
    {% else %}
        {% include 'snipplets/banner-services/banner-services.tpl' %}
    {% endif %}

{% elseif section_select == 'main_categories' %}

    {#  **** Main categories ****  #}
    {% if show_help or (show_component_help and not has_main_categories) %}
        {% snipplet 'defaults/home/main_categories_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-categories.tpl' %}
    {% endif %}

{% elseif section_select == 'products' %}

    {#  **** Featured products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with {products_title: 'Destacados' | translate, section_id: 'featured'} %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_featured': true} %}
    {% endif %}

{% elseif section_select == 'new' %}

    {#  **** New products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with {products_title: 'Novedades' | translate, section_id: 'new'} %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_new': true} %}
    {% endif %}

{% elseif section_select == 'sale' %}

    {#  **** Sale products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with {products_title: 'Ofertas' | translate, section_id: 'sale'} %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_sale': true} %}
    {% endif %}

{% elseif section_select == 'promotion' %}

    {#  **** Promotional products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with {products_title: 'Promociones' | translate, section_id: 'promotion'} %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_promotion': true} %}
    {% endif %}

{% elseif section_select == 'best_seller' %}

    {#  **** Best sellers products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with {products_title: 'Más vendidos' | translate, section_id: 'best-seller'} %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_best_seller': true} %}
    {% endif %}

{% elseif section_select == 'welcome' %}

    {#  **** Welcome message ****  #}
	{% if show_help or (show_component_help and not has_welcome_message) %}
		{% include 'snipplets/defaults/home/institutional_message_help.tpl' with { title: 'Mensaje de bienvenida'| translate, welcome_message: true, data_store: 'home-welcome-message' }  %}
	{% else %}
		{% include 'snipplets/home/home-welcome-message.tpl' %}
	{% endif %}

{% elseif section_select == 'categories' %}

    {#  **** Categories banners ****  #}

    {% if show_help or (show_component_help and not has_banners) %}
        {% include 'snipplets/defaults/home/banners_help.tpl' with { banner_name: 'category', banner_title: 'Categoría' | translate, help_text: 'Podés destacar categorías de tu tienda desde' | translate, section_name: 'Banners de categorías' | translate, banner_quantity: 2 }  %}
    {% else %}
        {% include 'snipplets/home/home-banners.tpl' with {'has_banner': true} %}
    {% endif %}

{% elseif section_select == 'promotional' %}

    {#  **** Promotional banners ****  #}
    {% if show_help or (show_component_help and not has_promotional_banners) %}
        {% include 'snipplets/defaults/home/promotional_banners_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-banners.tpl' with {'has_banner_promotional': true} %}
    {% endif %}
    
{% elseif section_select == 'banner_products' %}

    {#  **** Products + Banner ****  #}
    {% if show_help or (show_component_help and not has_banner_products) %}
        {% include 'snipplets/defaults/home/banner_products_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-banner-products.tpl' %}
    {% endif %}

{% elseif section_select == 'featured_banner' %}

    {#  **** Horizontal banner ****  #}
    {% if show_help or (show_component_help and not has_featured_banner) %}
        <section class="js-section-banner-home section-home section-banners-home position-relative overflow-none" data-store="home-banner-featured" data-transition="fade-in-up">
            {% include 'snipplets/defaults/home/banners_help.tpl' with { banner_name: 'Banner destacado', banner_title: 'Destaque' | translate, help_text: 'Podés subir tus imágenes desde' | translate, section_name: 'Banner destacado' | translate, banner_quantity: 1 }  %}
        </section>
	{% else %}
        {% include 'snipplets/home/home-banners.tpl' with {'has_banner_featured': true} %}
    {% endif %}

{% elseif section_select == 'instafeed' %}

    {#  **** Instafeed ****  #}
	{% if show_help or (show_component_help and not has_instafeed) %}
		{% include 'snipplets/defaults/home/instafeed_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-instafeed.tpl' %}
	{% endif %}

{% elseif section_select == 'video' %}

	{#  **** Video embed ****  #}
	{% if show_help or (show_component_help and not has_video) %}
		{% snipplet 'defaults/home/video_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-video.tpl' %}
	{% endif %}

{% elseif section_select == 'modules' %}

	{#  **** Modules ****  #}
	<section class="section-home section-home-module position-relative" data-store="home-image-text-module">
		{% if show_help or (show_component_help and not has_image_and_text_module) %}
			{% include 'snipplets/defaults/home/image_text_modules_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-banners.tpl' with {'has_module': true} %}
		{% endif %}
	</section>

{% elseif section_select == 'brands' %}

    {#  **** Brands ****  #}
	{% if show_help or (show_component_help and not has_brands) %}
		{% snipplet 'defaults/home/brands_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-brands.tpl' %}
	{% endif %}


{% elseif section_select == 'extra_menu' %}

    {#  **** Extra menu ****  #}
    {% if show_help or (show_component_help and not has_extra_menu) %}
        {% snipplet 'defaults/home/extra_menu_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-extra-menu.tpl' %}
    {% endif %}

{% elseif section_select == 'institutional' %}

    {#  **** Module with image and text ****  #}
    {% if show_help or (show_component_help and not has_institutional_message) %}
		{% include 'snipplets/defaults/home/institutional_message_help.tpl' with { title: 'Mensaje institucional'| translate, data_store: 'home-institutional-message' }  %}
	{% else %}
        {% include 'snipplets/home/home-institutional.tpl' with {'textoverimage': true} %}
    {% endif %}

{% elseif section_select == 'testimonials' %}

	{#  **** Testimonials slider ****  #}
	{% if show_help or (show_component_help and not has_testimonials) %}
		{% snipplet 'defaults/home/testimonials_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-testimonials.tpl' %}
	{% endif %}

{% elseif section_select == 'faq' %}

    {#  **** Frequently Asked Questions ****  #}
    {% if show_help or (show_component_help and not has_faq) %}
        {% snipplet 'defaults/home/faq_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-faq.tpl' %}
    {% endif %}
    
{% elseif section_select == 'blog' %}

	{#  **** Blog posts ****  #}
    {% if show_help or (show_component_help and not has_blog_posts) %}
        {% include 'snipplets/defaults/home/blog_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-blog.tpl' %}
    {% endif %}

{% elseif section_select == 'main_product' %}

	{#  **** Main product ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% snipplet 'defaults/home/main_product_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-main-product.tpl' %}
	{% endif %}

{% elseif section_select == 'newsletter' %}

    {% include 'snipplets/home/home-newsletter.tpl' %}

{% elseif section_select == 'grid' %}

    {#  **** Grid banners ****  #}
    {% if show_help or (show_component_help and not has_grid_banners) %}
        {% include 'snipplets/defaults/home/grid_banners_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-grid-banners.tpl' with {'textoverimage': true} %}
    {% endif %}

{% endif %}
