{% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
    {% set sn_url = attribute(store,sn) %}
    {% if sn_url %}
        <a class="social-icon" href="{{ sn_url }}" target="_blank" aria-label="{{ sn }} {{ store.name }}">
            {% if sn == "facebook" %}
                <svg class="icon-inline icon-lg"><use xlink:href="#facebook-f"/></svg>
            {% elseif sn == "instagram" %}
                <svg class="icon-inline icon-lg"><use xlink:href="#instagram"/></svg>
            {% elseif sn == "pinterest" %}
                <svg class="icon-inline icon-lg"><use xlink:href="#pinterest"/></svg>
            {% elseif sn == "youtube" %}
                <svg class="icon-inline icon-lg"><use xlink:href="#youtube"/></svg>                
            {% elseif sn == "tiktok" %}
                <svg class="icon-inline icon-lg"><use xlink:href="#tiktok"/></svg>               
            {% else %}
                <svg class="icon-inline icon-lg"><use xlink:href="#twitter"/></svg>
            {% endif %}
        </a>
    {% endif %}
{% endfor %}
{% if settings.linkedin_account %}
    <a class="social-icon icon-lg" href="{{ settings.linkedin_account }}" target="_blank" aria-label="linkedin {{ store.name }}">
        <svg class="icon-inline"><use xlink:href="#linkedin"/></svg>
    </a>
{% endif %}