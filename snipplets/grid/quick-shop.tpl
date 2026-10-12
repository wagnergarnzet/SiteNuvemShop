{% if settings.quick_shop %}
    {% embed "snipplets/modal.tpl" with{modal_id: 'quickshop-modal', modal_class: 'quickshop bottom', modal_position: 'bottom', modal_transition: 'slide', modal_footer: false, modal_width: 'centered modal-bottom-sheet modal-centered-md modal-centered-medium', modal_header_class: 'js-quickshop-header modal-header-reverse d-none', modal_body_class: 'modal-scrollable p-0 p-md-3'} %}
        {% block modal_body %}
            <div class="js-item-product modal-scrollable modal-scrollable-area" data-product-id="">
                <div class="js-product-container js-quickshop-container js-quickshop-modal js-quickshop-modal-shell" data-variants="" data-quickshop-id="">
                    <div class="quickshop-grid">
                        <div class="quickshop-image-container">
                            <div class="js-quickshop-image-padding">
                                <img srcset="" class="js-item-image js-quickshop-img quickshop-image img-absolute-centered"/>
                            </div>
                        </div>
                        <div class="js-item-variants quickshop-item-variants">
                            <a class="js-modal-close modal-close">
                                <svg class="icon-inline svg-icon-text"><use xlink:href="#times"/></svg>
                            </a>
                            <div class="js-item-name quickshop-item-name mb-2 mb-md-0 mr-3"></div>
                            <div class="d-flex align-items-center justify-content-start mb-2 mr-md-1">
                                <span class="js-compare-price-display price-compare h3 ml-2"></span>
                                <span class="js-price-display product-price"></span>
                            </div>
                        </div>
                        <div id="quickshop-form" class="quickshop-form"></div>
                    </div>
                </div>
            </div>
        {% endblock %}
    {% endembed %}
{% endif %}