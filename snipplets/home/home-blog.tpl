{% set num_posts = 0 %}
{% set blog_posts_format = settings.blog_posts_format_mobile %}
{% set is_blog_slider = blog_posts_format == 'slider' %}
{% for post in ['post_01', 'post_02', 'post_03', 'post_04'] %}
	{% set post_title = attribute(settings,"#{post}_title") %}
	{% set has_post =  post_title or "#{post}.jpg" | has_custom_image %}
	{% if has_post %}
		{% set num_posts = num_posts + 1 %}
	{% endif %}
{% endfor %}

{% if num_posts > 0 %}
<section class="section-home section-blog-home" data-store="home-blog-posts">
    <div class="container">
        
        {% if settings.blog_title %}
        <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto mb-3 row">
            <div class="col-12 text-center">
                <h2 class="text-heading mb-0">{{ settings.blog_title }}</h2>
            </div>
            {% if settings.blog_subtitle %}
            <div class="col-12 text-center mt-3">
                <p class="home-subtitle text-subtitle">{{ settings.blog_subtitle }}</p>
            </div>
            {% endif %}
        </div>
        {% endif %}

        {% if is_blog_slider %}
        <div class="position-relative">
            <div class="js-swiper-blog-posts swiper">
                <div class="swiper-wrapper swiper-mobile-only flex-nowrap flex-md-wrap row row-grid">
        {% else %}
        <div class="row">
        {% endif %}
            {% for post in ['post_01', 'post_02', 'post_03', 'post_04'] %}
                {% set post_image = "#{post}.jpg" | has_custom_image %}
                {% set post_image_url = "#{post}.jpg" | static_url %}
                {% set post_title = attribute(settings,"#{post}_title") %}
                {% set post_url = attribute(settings,"#{post}_url") %}
                {% set post_desc = attribute(settings,"#{post}_description") %}
                {% set has_post = post_title or post_image %}
                {% if has_post %}
                    <div class="home-blog-post{% if is_blog_slider %} swiper-slide col-grid col-12 col-md-{% if num_posts == 1 %}6 offset-md-3{% elseif num_posts == 2 %}6{% elseif num_posts == 3 %}4{% elseif num_posts == 4 %}3{% elseif num_posts == 5 %}auto{% elseif num_posts == 6 %}2{% endif %} mb-md-0{% else %} col-12 col-md-{% if num_posts == 1 %}6 offset-md-3{% elseif num_posts == 2 %}6{% elseif num_posts == 3 %}4{% elseif num_posts == 4 %}3{% elseif num_posts == 5 %}auto{% elseif num_posts == 6 %}2{% endif %} mb-4 mb-md-0{% endif %}">
                        {% if post_image %}
                            <div class="home-post-image mb-3">
                                {% if post_url %}
                                    <a class="textpost-link" href="{{ post_url }}"{% if post_title %} title="{{ post_title }}" aria-label="{{ post_title }}"{% else %} title="{{ 'publicación de' | translate }} {{ store.name }}" aria-label="{{ 'publicación de' | translate }} {{ store.name }}"{% endif %}>
                                {% endif %}
                                <div class="home-post-image">
                                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ "#{post}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{post}.jpg" | static_url | settings_image_url('huge') }} 640w' data-sizes="auto" class="w-100 lazyload lazyautosizes" alt="{{ image.alt ?: (post_title ?: 'Imagen de la publicación'|translate) }}"/>
                                </div>
                                {% if post_url %}</a>{% endif %}
                            </div>
                        {% endif %}
                        {% if post_title %}
                            {% if not settings.post_title_seo %}
                            <div class="textpost-text{% if textoverimage %} over-image{% endif %}{% if not post_image %} py-3{% endif %}">
                                {% if post_url %}
                                    <a class="textpost-link" href="{{ post_url }}"{% if post_title %} title="{{ post_title }}" aria-label="{{ post_title }}"{% else %} title="{{ 'publicación de' | translate }} {{ store.name }}" aria-label="{{ 'publicación de' | translate }} {{ store.name }}"{% endif %}>
                                {% endif %}
                                <h3 class="mb-2">
                                    {{ post_title }}
                                </h3>
                                {% if post_url %}</a>{% endif %}
                            </div>
                            {% endif %}
                        {% endif %}
                        {% if post_desc %}
                            <p>{{ post_desc }}</p>
                        {% endif %}
                        {% if post_url and settings.blog_more_text %}
                            <a class="btn btn-blog btn-small btn-secondary d-inline-block" href="{{ post_url }}"{% if post_title %} title="{{ post_title }}" aria-label="{{ post_title }}"{% else %} title="{{ 'publicación de' | translate }} {{ store.name }}" aria-label="{{ 'publicación de' | translate }} {{ store.name }}"{% endif %}>
                                {{ settings.blog_more_text }}
                            </a>
                        {% endif %}
                    </div>
                {% endif %}
            {% endfor %}
        {% if is_blog_slider %}
                </div>
            </div>
            <div class="js-swiper-blog-posts-pagination position-relative swiper-pagination d-block d-md-none mt-4"></div>
        {% endif %}
        </div>
        <div class="row">
            <div class="col-12 text-center">
            {% if settings.blog_text and settings.blog_url %}
                <a class="btn btn-primary d-inline-block mt-md-5" href="{{ settings.blog_url }}">{{ settings.blog_text }}</a>
            {% endif %}
            </div>
        </div>
    </div>
</section>
{% endif %}
