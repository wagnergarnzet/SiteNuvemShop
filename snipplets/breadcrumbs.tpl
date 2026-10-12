{# /*============================================================================
  #Page breadcrumbs
==============================================================================*/
#Properties

#Breadcrumb
    //breadcrumbs_custom_class for custom CSS classes
#}

{% if breadcrumbs %}
    <div class="breadcrumbs {{ breadcrumbs_custom_class }}">
        <a class="crumb" href="{{ store.url }}" title="{{ store.name }}">{{ "Inicio" | translate }}</a>
        <svg class="icon-inline icon-xs svg-icon-secondary mr-1 ml-1"><use xlink:href="#chevron"></use></svg>
        {% if template == 'page' %}
            <span class="crumb active">{{ page.name }}</span>
        {% elseif template == 'cart' %}
            <span class="crumb active">{{ "Carrito de compras" | translate }}</span>
        {% elseif template == 'search' %}
            <span class="crumb active">{{ "Resultados de búsqueda" | translate }}{% if query %} por <strong>{{ query }}</strong> ({{ query|length }} resultados){% endif %}</span>
        {% elseif template == 'account.order' %}
            <a class="crumb" href="{{ store.customer_home_url }}" title="{{ "Mi cuenta" }}">{{ 'Mi cuenta' | translate }}</a>
            <svg class="icon-inline icon-xs svg-icon-secondary mr-1 ml-1"><use xlink:href="#chevron"></use></svg>
            <span class="crumb active">{{ 'Orden {1}' | translate(order.number) }}</span>
        {% elseif template == 'account.newpass' %}
            <a class="crumb" href="{{ store.customer_home_url }}" title="{{ "Mi cuenta" }}">{{ 'Mi cuenta' | translate }}</a>
            <svg class="icon-inline icon-xs svg-icon-secondary mr-1 ml-1"><use xlink:href="#chevron"></use></svg>
            <span class="crumb active">{{ 'Cambiar contraseña' | translate }}</span>
        {% elseif template == 'blog' %}
            <span class="crumb active">{{ 'Blog' | translate }}</span>
        {% elseif template == 'blog-post' %}
            <a class="crumb" href={{ store.blog_url }} title="{{ 'Blog' | translate }}">{{ 'Blog' | translate }}</a>
            <svg class="icon-inline icon-xs svg-icon-secondary mr-1 ml-1"><use xlink:href="#chevron"></use></svg>
            <span class="crumb active">{{ post.title }}</span>
        {% elseif template == 'product' %}
            {% for crumb in breadcrumbs %}
                {% if not crumb.last %}
                    <a class="crumb" href="{{ crumb.url }}" title="{{ crumb.name }}">{{ crumb.name }}</a>
    	            <svg class="icon-inline icon-xs svg-icon-secondary mr-1 ml-1"><use xlink:href="#chevron"></use></svg>
                {% endif %}
            {% endfor %}
        {% else %}
            {% for crumb in breadcrumbs %}
                {% if crumb.last %}
                    <span class="crumb active">{{ crumb.name }}</span>
                {% else %}
                    <a class="crumb" href="{{ crumb.url }}" title="{{ crumb.name }}">{{ crumb.name }}</a>
    	            <svg class="icon-inline icon-xs svg-icon-secondary mr-1 ml-1"><use xlink:href="#chevron"></use></svg>
                {% endif %}
            {% endfor %}
        {% endif %}
    </div>
{% endif %}
