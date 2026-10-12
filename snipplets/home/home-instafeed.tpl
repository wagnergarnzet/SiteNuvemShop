{% set has_token_or_images = (settings.instafeed_posts == "instagram" and store.hasInstagramToken()) or (settings.instafeed_posts == "custom" and settings.custom_feed) %}

{% if store.instagram and settings.instafeed_user or has_token_or_images %}
    {% set instuser = store.instagram|split('/')|last %}
    {% set numposts = settings.instafeed_count %}
    {% set instafeed_style = settings.instafeed_style %}
    {% set instafeed_user_position = settings.instafeed_user_position %}
    {% set show_instafeed_user = settings.instafeed_user and store.instagram %}
    {% if has_token_or_images %}
        {% set col_lg_class = instafeed_user_position == 'top' ? 'col-lg-12' : 'col-lg-2 mb-md-0' %}
        {% set feed_col_lg_class = instafeed_user_position == 'top' or not show_instafeed_user ? 'col-lg-12' : 'col-lg-10' %}
    {% else %}
        {% set col_lg_class = 'py-3' %}
        {% set feed_col_lg_class = 'col-lg-12' %}
    {% endif %}

    <section class="section-home section-instafeed" data-store="home-instagram-feed">
        <div class="{% if instafeed_style == "full-width" %}container-fluid{% else %}container{% endif %}">
            <div class="row no-gutters">
                {% if show_instafeed_user %}
                    <div class="col-12 mb-3 {{ col_lg_class }}">
                        <div class="instafeed-intro text-center d-flex flex-column justify-content-center align-items-center">
                            <a target="_blank" href="{{ store.instagram }}" aria-label="@{{ instuser }}">
                                <svg class="icon-inline icon-3x mb-1"><use xlink:href="#instagram"/></svg>
                            </a>
                            <span>{{ "Seguínos en Instagram" | translate }}</span>
                            <a target="_blank" href="{{ store.instagram }}" class="instafeed-title" aria-label="@{{ instuser }}">@{{ instuser }}</a>
                        </div>
                    </div>
                {% endif %}
                {% if settings.instafeed_posts == "custom" and settings.custom_feed %}
                    <div class="col-12 {{ feed_col_lg_class }}">
                        <div id="instagram-feed" class="instagram-feed mt-md-0 row no-gutters">
                            {% for post in settings.custom_feed[:numposts] %}
                                <div class="instafeed-col col-6 {% if numposts == '8' %}col-md-3{% else %}col-md{% endif %} col-lg">
                                    {% if post.link %}
                                        <a class="instafeed-link" href="{{ post.link }}" target="_blank">
                                    {% else %}
                                        <a class="instafeed-link" href="{{ post.image | static_url | settings_image_url('original') }}" data-fancybox="instafeed-gallery">
                                    {% endif %}
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ post.image | static_url | settings_image_url('large') }} 480w, {{ post.image | static_url | settings_image_url('huge') }} 640w' data-sizes="auto" class="instafeed-img lazyautosizes lazyload" {% if post.image.alt %}alt="{{post.image.alt}}"{% endif %}/>
                                    </a>
                                </div>
                            {% endfor %}
                        </div>
                    </div>
                {% elseif store.hasInstagramToken() %}
                    <div class="col-12 {{ feed_col_lg_class }}">
                        <div id="instagram-feed" class="js-ig-success instagram-feed mt-md-0 row no-gutters" 
                            data-ig-feed
                            data-ig-items-count="{{ numposts }}"
                            data-ig-item-class="instafeed-col col-6 {% if numposts == '8' %}col-md-3{% else %}col-md{% endif %} col-lg"
                            data-ig-link-class="instafeed-link"
                            data-ig-image-class="instafeed-img fade-in"
                            data-ig-aria-label="@{{ instuser }}"
                            style="display: none;">  
                        </div>
                    </div>
                {% endif %}
            </div>
        </div>
    </section>
{% endif %}
