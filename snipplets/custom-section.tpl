<section class="section-custom custom-section-{{ loop.index }}">
    <div class="container">
        <div class="row ">
            <div class="col-10 offset-1">
                <div class="row align-items-center justify-content-center">
                    {% if section_image %}
                        <div class="section-image col-12 col-md">
                            <img class="custom-section-image img-fluid lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ "#{section}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{section}.jpg" | static_url | settings_image_url('huge') }} 640w" data-expand="-10" alt="{{ 'Imagen de' | translate }} {{ store.name }}" />
                        </div>
                    {% endif %}
                    {% if section_title or section_text %}
                        <div class="section-content col-12 col-md">
                            <h2 class="custom-section-title">{{ section_title }}</h2>
                            <p class="custom-section-text">{{ section_text }}</p>
                            {% if section_url %}
                                <a href="{{ section_url }}" {% if section_url_external %}target="_blank"{% endif %} class="d-inline-block btn-medium custom-section-link rounded-theme">{% if section_button %}{{ section_button }}{% else %}{{ "Ver más" | translate }}{% endif %}</a>
                            {% endif %}
                        </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
</section>