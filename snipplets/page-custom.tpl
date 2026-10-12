{% macro for_each_section_include(template) %}
    {% set num_sections = 0 %}
    {% set available_sections = [] %}
    {% for section in ['custom_page_section_1', 'custom_page_section_2', 'custom_page_section_3', 'custom_page_section_4', 'custom_page_section_5'] %}
        {% set section_title = attribute(settings,"#{section}_title") %}
        {% set section_text = attribute(settings,"#{section}_text") %}
        {% set has_sections = section_title or section_text %}
        {% if has_sections %}
            {% set num_sections = num_sections + 1 %}
            {% set available_sections = available_sections | merge([section]) %}
        {% endif %}
    {% endfor %}
    {% for section in available_sections %}
        {% set section_title = attribute(settings,"#{section}_title") %}
        {% set section_image = "#{section}.jpg" | has_custom_image %}
        {% set section_text = attribute(settings,"#{section}_text") %}
        {% set section_url = attribute(settings,"#{section}_url") %}
        {% set section_button = attribute(settings,"#{section}_button") %}
        {% set section_button_bg_color = attribute(settings,"#{section}_button_background_color") %}
        {% set section_button_text_color = attribute(settings,"#{section}_button_foreground_color") %}
        {% set section_url_external = attribute(settings,"#{section}_external") %}
        {% include template %}
    {% endfor %}
{% endmacro %}
{% import _self as custom_section %}

<main class="custom-page">
    {{ custom_section.for_each_section_include('snipplets/custom-section.tpl') }}
</main>