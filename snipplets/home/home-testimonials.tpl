{% set has_home_testimonials = false %}
{% set num_testimonials = 0 %}
{% for testimonial in ['testimonial_01', 'testimonial_02', 'testimonial_03', 'testimonial_04', 'testimonial_05', 'testimonial_06', 'testimonial_07', 'testimonial_08'] %}
	{% set testimonial_image = "#{testimonial}.jpg" | has_custom_image %}
	{% set testimonial_name = attribute(settings,"#{testimonial}_name") %}
	{% set testimonial_description = attribute(settings,"#{testimonial}_description") %}
	{% set has_testimonial = testimonial_name or testimonial_description %}
	{% if has_testimonial %}
		{% set has_home_testimonials = true %}
		{% set num_testimonials = num_testimonials + 1 %}
	{% endif %}
{% endfor %}

{% if has_home_testimonials %}
    <section class="home-testimonials section-home" data-store="home-testimonials">
        
        {% if settings.testimonials_title %}
        <div class="container">
            <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
                <div class="col-12 text-center">
                    <h2 class="text-heading mb-0">{{ settings.testimonials_title }}</h2>
                </div>
                {% if settings.testimonials_subtitle %}
                <div class="col-12 text-center mt-2">
                    <p class="home-subtitle text-subtitle">{{ settings.testimonials_subtitle }}</p>
                </div>
                {% endif %}
            </div>
        </div>
        {% endif %}
        
        <div class="container position-relative">
            <div class="js-home-testimonials swiper">
                <div class="swiper-wrapper">
                {% for testimonial in ['testimonial_01', 'testimonial_02', 'testimonial_03', 'testimonial_04', 'testimonial_05', 'testimonial_06', 'testimonial_07', 'testimonial_08'] %}
                    {% set testimonial_image = "#{testimonial}.jpg" | has_custom_image %}
                    {% set testimonial_name = attribute(settings,"#{testimonial}_name") %}
                    {% set testimonial_description = attribute(settings,"#{testimonial}_description") %}
                    {% set has_testimonial = testimonial_name or testimonial_description or testimonial_image %}
                    {% if has_testimonial %}
                    <div class="testimonial-swiper swiper-slide slide-container">
                        <div class="testimonial {% if not testimonial_image %}no-image{% endif %}">
                            {% if testimonial_image %}
                                <div class="testimonial-image d-flex align-items-center justify-content-center">
                                    <img class="d-block w-100 mb-3 lazyautosizes lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-sizes="auto" data-expand="-10" data-srcset='{{ "#{testimonial}.jpg" | static_url | settings_image_url("thumb") }} 100w, {{ "#{testimonial}.jpg" | static_url | settings_image_url("large") }} 480w' {% if testimonial_name %}alt="{{ testimonial_name }}"{% else %}alt="{{ 'Testimonio de' | translate }} {{ store.name }}"{% endif %} />
                                    <div class="placeholder-fade"></div>
                                </div>
                            {% endif %}
                            {% if settings.testimonials_stars %}
                                <div class="testimonial-stars">
                                    <svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
                                    <svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
                                    <svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
                                    <svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
                                    <svg class="icon-inline icon-lg fill-star"><use xlink:href="#star"/></svg>
                                </div>
                            {% endif %}
                            {% if testimonial_description %}
                                <p class="testimonial-description">{{ testimonial_description }}</p>
                            {% endif %}
                            {% if testimonial_name %}
                                <div class="testimonial-title">
                                    {{ testimonial_name }}
                                </div>
                            {% endif %}
                        </div>
                    </div>
                    {% endif %}
                {% endfor %}
                </div>
            </div>
            <div class="js-swiper-testimonials-prev swiper-button-prev d-none d-md-block svg-icon-secondary">
                <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-swiper-testimonials-next swiper-button-next d-none d-md-block svg-icon-secondary">
                <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-testimonials-pagination d-block d-md-none text-center"></div>
        </div>
    </section>
{% endif %}