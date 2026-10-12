{% set columns = 3 %}

{% set banner_view_box = '0 0 1000 1000' %}

<section class="home-promos section-home" data-store="home-banner-products">
    <div class="container mb-3">
        <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
            <div class="col-12 text-center">
                <h2 class="text-heading mb-0">{{ 'Productos con banner' | translate }}</h2>
            </div>
        </div>
    </div>
    <div class="container rounded-5 position-relative content">
        <div class="row">
            <div class="col-12 col-lg px-md-3 d-lg-flex flex-column align-items-center justify-content-center">
                <svg viewBox='{{ banner_view_box }}'><use xlink:href="#item-product-placeholder-3"/></svg>
            </div>
            <div class="promo-products col-12 col-lg-9 pr-0 pr-md-4 pt-4 py-md-4 d-flex align-items-center">
                <div class="js-swiper-promos-demo swiper">
                    <div class="swiper-wrapper swiper-products-slider flex-nowrap">
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_4': true, 'section_columns_desktop': 3, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_5': true, 'section_columns_desktop': 3, 'section_columns_mobile': 2}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_6': true, 'section_columns_desktop': 3, 'section_columns_mobile': 2}  %}
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_7': true, 'section_columns_desktop': 3, 'section_columns_mobile': 2}  %}
                    </div>                
                </div>
                <div class="js-swiper-promos-demo-prev swiper-button-prev swiper-button-prev-inside d-none d-md-block">
                    <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                </div>
                <div class="js-swiper-promos-demo-next swiper-button-next swiper-button-next-inside d-none d-md-block">
                    <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
                </div>
            </div>
        </div>         
    </div>
</section>