<div class="mb-4 pb-1">
    <div class="js-append-filters mb-4" style="display: none;">
        <h3 class="mb-2">{{ 'Filtro aplicado' | translate }}</h3>
    </div>

    {% if parent_category and parent_category.id!=0 %}
        <a href="{{ parent_category.url }}" title="{{ parent_category.name }}" class="category-back d-block{% if filter_categories %} mb-4{% endif %}">
        <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
        {{ parent_category.name }}</a>
    {% endif %}

    {% if filter_categories %}
        <div class="d-block">
            <h3 class="mb-4">{{ category.id!=0 ? ("Subcategorías" | translate) :("Categorías" | translate) }}</h3>
            <ul class="list-unstyled"> 
                {% for category in filter_categories %}
                    <li data-item="{{ loop.index }}" class="js-category-sidebar-item mb-3"><a href="{{ category.url }}" title="{{ category.name }}">{{ category.name }}</a></li>
                {% endfor %}
            </ul>
        </div>
    {% endif %}
</div>
