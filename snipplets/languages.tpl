{% if languages | length > 1 %}
    <div class="languages col-auto p-0 ml-2">
        {% for language in languages %}
            {% set class = language.active ? "" : "opacity-50" %}
            {% if settings.language_icons %}
                <a href="{{ language.url }}" class="{{ class }} d-inline-block px-1">
                    <div class="flag">
                        {% if language.country == "BR" %}
                            <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/br.svg' | static_url }}" alt="{{ language.name }}" />
                        {% elseif language.country == "AR" %}
                            <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/ar.svg' | static_url }}" alt="{{ language.name }}" />
                        {% elseif language.country == "US" %}
                            <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/en.svg' | static_url }}" alt="{{ language.name }}" />                                
                        {% else %}
                            <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
                        {% endif %}
                    </div>
                </a>
            {% else %}
            <a href="{{ language.url }}" class="{{ class }} flag pl-2">{{ language.country }}</a>
            {% endif %}
        {% endfor %}
    </div>
{% endif %}