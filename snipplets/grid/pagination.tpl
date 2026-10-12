{% if infinite_scroll %}
	{% if pages.current == 1 and not pages.is_last %}
		<div class="js-load-more text-center my-4">
			<a class="btn btn-default d-inline-block">
				{{ 'Mostrar más productos' | t }}
				<span class="js-load-more-spinner ml-2" style="display:none;">
					<svg class="icon-inline icon-spin"><use xlink:href="#spinner-third"/></svg>
				</span>
			</a>
		</div>
		<div id="js-infinite-scroll-spinner" class="my-4 text-center w-100" style="display:none">
			<svg class="icon-inline icon-30px svg-icon-text icon-spin"><use xlink:href="#spinner-third"/></svg>
		</div>
	{% endif %}
{% else %}
	{% if pages.numbers %}
		<div class="row justify-content-center align-items-center mt-5">
			<div class="col-auto">
				<a {% if pages.previous %}href="{{ pages.previous }}"{% endif %} class="pagination-button-prev swiper-button-prev {% if not pages.previous %}opacity-30 disabled{% endif %}">
					<svg class="icon-inline icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
				</a>
			</div>
			<div class="col-auto">
				<div class="mb-0 text-center">
                    {% for page in pages.numbers %}
                        {% if page.selected %}
                        <div class="js-page-link-{{ page.number }} pagination-input-container d-inline-block {% if not pages.previous %}pagination-input-container-wide{% endif %}">
                            <span> 
                                {{ 'Página' | t }}
                            </span> 
                            <input type="number" value="{{ page.number }}" class="js-mobile-paginator-input pagination-input text-center"/> 
                            <span> 
                                {{ 'de ' | t }} {{ pages.amount }}
                            </span> 
                        </div>
                        {% else %}
                            <a href="{{ page.url }}" class="js-page-link-{{ page.number }} hidden p-all-quarter">{{ page.number }}</a>
                        {% endif %}
                    {% endfor %}
				</div>
			</div>
			<div class="col-auto">
				<a {% if pages.next %}href="{{ pages.next }}"{% endif %} class="pagination-button-next swiper-button-next {% if not pages.next %}opacity-30 disabled{% endif %}">
					<svg class="icon-inline"><use xlink:href="#chevron"/></svg>
				</a>
			</div>
		</div>
	{% endif %}
{% endif %}