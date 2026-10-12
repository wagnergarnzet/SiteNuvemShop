{% set faq_items_keys = ['faq_item_01', 'faq_item_02', 'faq_item_03', 'faq_item_04', 'faq_item_05', 'faq_item_06', 'faq_item_07', 'faq_item_08', 'faq_item_09', 'faq_item_10'] %}

{% set has_faq = false %}
{% for faq_item in faq_items_keys %}
    {% set faq_question = attribute(settings, faq_item ~ '_question') %}
    {% set faq_answer = attribute(settings, faq_item ~ '_answer') %}
    {% if faq_question or faq_answer %}
        {% set has_faq = true %}
    {% endif %}
{% endfor %}

{% if has_faq %}

    {% if not faq_page %}
        {% set faq_section_class = 'section-home section-faq' %}
        {% set faq_data_store = 'home-faq' %}
        {% set faq_id_prefix = 'home-faq-' %}

        {% if settings.faq_colors and not faq_no_colors %}
            {% set faq_section_class = faq_section_class ~ ' section-home-color' %}
        {% endif %}

        <section class="{{ faq_section_class }}" data-store="{{ faq_data_store }}" data-transition="fade-in-up">
            <div class="container">
                {% if settings.faq_title or settings.faq_subtitle %}
                    <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
                        {% if settings.faq_title %}
                            <div class="col-12 text-center">
                                <h2 class="text-heading mb-0">{{ settings.faq_title }}</h2>
                            </div>
                        {% endif %}
                        {% if settings.faq_subtitle %}
                            <div class="col-12 text-center mt-2">
                                <p class="home-subtitle text-subtitle mb-0">{{ settings.faq_subtitle }}</p>
                            </div>
                        {% endif %}
                    </div>
                {% endif %}
    {% endif %}

            <div class="faq-list mx-auto mb-3 js-accordion-group">
                {% for faq_item in faq_items_keys %}
                    {% set faq_question = attribute(settings, faq_item ~ '_question') %}
                    {% set faq_answer = attribute(settings, faq_item ~ '_answer') %}
                    {% if faq_question or faq_answer %}
                        {% set item_id = faq_id_prefix ~ loop.index %}
                        <div class="faq-item js-accordion-container">
                            <button type="button" class="faq-question js-accordion-toggle" aria-expanded="false" aria-controls="{{ item_id }}">
                                <span class="faq-question-text">{{ faq_question }}</span>
                                <span class="faq-question-icon">
                                    <span class="js-accordion-toggle-inactive">
                                        <svg class="icon-inline icon-md"><use xlink:href="#plus"/></svg>
                                    </span>
                                    <span class="js-accordion-toggle-active" style="display: none;">
                                        <svg class="icon-inline icon-md"><use xlink:href="#minus"/></svg>
                                    </span>
                                </span>
                            </button>
                            <div id="{{ item_id }}" class="faq-answer js-accordion-content" style="display: none;">
                                <div class="faq-answer-inner">
                                    {% if faq_answer %}
                                        {{ faq_answer }}
                                    {% endif %}
                                </div>
                            </div>
                        </div>
                    {% endif %}
                {% endfor %}
            </div>

    {% if not faq_page %}
            </div>
        </section>
    {% endif %}
{% endif %}
