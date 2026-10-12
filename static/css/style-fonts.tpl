{% set fonts_url = '' %}

{% if params.preview %}
            
    {# If page is loaded from customization page on the admin, load all fonts #}

    {% set fonts_url = 'https://fonts.googleapis.com/css?family=Barlow:300,400,700|Bebas+Neue:400|Bree+Serif:400,700|Cinzel:400,700|Inter:300,400,700|Josefin+Sans:400,700|Lato:300,400,700|Libre+Baskerville:400,700|Lora:400,700|Merriweather:400,700|Montserrat:300,400,500,600,700|Nunito:400,700|Open+Sans:300,400,700|Playfair+Display:400,700|Plus+Jakarta+Sans:400|Poppins:300,400,700|PT+Sans:400,700|Quicksand:400,700|Raleway:400,700|Roboto:400,700|Roboto+Condensed:400,700|Roboto+Mono:400,700|Roboto+Slab:400,700|Rubik:400,700|Sora:300,400,500,700|Urbanist:300,400,700|Fraunces:400,700|Onest:300,400,700|Quattrocento+Sans:400,700|Sacramento&display=swap' %}

{% else %}

    {# If page is NOT loaded from customization only load saved fonts #}

    {# Get only the saved fonts on settings #}

    {% set fonts = {} %}
    {% set fontSettings = [
        {
            'setting': settings.font_headings,
            'weightSetting': settings.font_headings_weight,
        },
        {
            'setting': settings.font_menu,
            'weightSetting': settings.font_menu_weight,
        },
        {
            'setting': settings.font_rest,
        },
    ] %}

    {% for fontSetting in fontSettings %}
        {% if fontSetting.setting %}
            {% set font = fontSetting.setting|trim('"')|split('"')|first %}
            {% set fontWeight = fontSetting.weightSetting ? fontSetting.weightSetting : '400' %}
            {% set existingFonts = fonts[font] ?? [] %}
            {% if fontWeight not in existingFonts %}
                {% set existingFonts = existingFonts|merge([fontWeight]) %}
                {% if fontSetting.setting == settings.font_menu and '400' not in existingFonts %}
                    {% set existingFonts = existingFonts|merge(['400'])|sort %}
                {% endif %}
            {% endif %}
            {% set fonts = fonts|merge({ (font): existingFonts }) %}
        {% endif %}
    {% endfor %}

    {# Add specific weights (400 and 700) for font_rest #}
    {% if settings.font_rest %}
        {% set restFontWeights = fonts[settings.font_rest] ?? [] %}
        {% set restFontWeights = restFontWeights|merge(['400', '700'])|sort %}
        {% set fonts = fonts|merge({ (settings.font_rest|trim('"')|split('"')|first): restFontWeights }) %}
    {% endif %}

    {% set formattedFonts = '' %}
    {% for font, weights in fonts %}
        {% set formattedFonts = formattedFonts ~ (loop.first ? '' : '|') ~ font|replace(' ', '+') ~ ':' ~ weights|join(',') %}
    {% endfor %}

    {% if formattedFonts %}
        {% set fonts_url = 'https://fonts.googleapis.com/css?family=' ~ formattedFonts ~ '&display=swap' %}
    {% endif %}

{% endif %}

{% if fonts_url %}
    {% if import_style %}
        @import url('{{ fonts_url }}');
    {% else %}
        <link rel="preload" as="style" href="{{ fonts_url }}">
    {% endif %}
{% endif %}
