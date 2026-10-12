{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Header
    //page_header_custom_class for custom CSS classes

#Title

#Breadcrumbs 

#}

<section class="page-header{% if template == 'product' %}-product mb-md-1{% else %} text-center text-md-left{% endif %} page-header-slim {{ page_header_custom_class }}" data-store="page-title">
    <div class="container{% if product_page %}-fluid{% endif %}">
        <div class="row align-items-center">
            {% if template != 'product' %}
                <div class="col-md-{% if not full_width_title %}6{% else %}12{% endif %}">
                    <h1 {% if template == 'product' %}id="product-name"{% endif %} class="text-heading {{ page_header_title_class }}" {% if template == "product" %}data-store="product-name-{{ product.id }}"{% endif %}>{% block page_header_text %}{% endblock %}</h1>
                    {% if template == 'category' and category.description %}
                        <p class="mb-0">{{ category.description }}</p>
                    {% endif %}
                </div>
            {% endif %}
            {% if not full_width_title %}
                <div class="col-12 {% if template == 'product' %}text-left p-0{% else %}col-md-6 text-center text-md-right{% endif %}">
                    {% include 'snipplets/breadcrumbs.tpl' %}
                </div>
            {% endif %}
            {% block page_header_image %}{% endblock %}
        </div>
    </div>
</section>
