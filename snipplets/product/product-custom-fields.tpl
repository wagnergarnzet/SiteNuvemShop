{% set cf1_name = settings.custom_cf1_name %}
{% set cf1_text = settings.custom_cf1_text %}
{% set cf1_property = 'properties[' ~ cf1_name ~ ']' %}
{% set cf2_name = settings.custom_cf2_name %}
{% set cf2_text = settings.custom_cf2_text %}
{% set cf2_property = 'properties[' ~ cf2_name ~ ']' %}
{% set has_cf1 = cf1_name and cf1_text %}
{% set has_cf2 = cf2_name and cf2_text %}

{% if has_cf1 and settings.custom_cf1_tag %}
    {% for tag in product.tags %}
        {% if tag == settings.custom_cf1_tag %}
            <div class="form-group">
                <label class="form-label" for="{{ cf1_property }}">{{ cf1_text | translate }}</label>
                <input type="text" class="form-control" name="{{ cf1_property }}">
            </div>
        {% endif %}
    {% endfor %}
{% elseif has_cf1 %}
    <div class="form-group">
        <label class="form-label" for="{{ cf1_property }}">{{ cf1_text | translate }}</label>
        <input type="text" class="form-control" name="{{ cf1_property }}">
    </div>
{% endif %}
{% if has_cf2 and settings.custom_cf2_tag %}
    {% for tag in product.tags %}
        {% if tag == settings.custom_cf2_tag %}
            <div class="form-group">
                <label class="form-label" for="{{ cf2_property }}">{{ cf2_text | translate }}</label>
                <input type="text" class="form-control" name="{{ cf2_property }}">
            </div>
        {% endif %}
    {% endfor %}
{% elseif has_cf2 %}
    <div class="form-group">
        <label class="form-label" for="{{ cf2_property }}">{{ cf2_text | translate }}</label>
        <input type="text" class="form-control" name="{{ cf2_property }}">
    </div>
{% endif %}