{#/*============================================================================
    #Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================
  
  Table of Contents

  	#Lazy load
  	#Notificactions
    #Modals
    #Tabs
  	#Header and nav
        // Nav
        // Search suggestions
	#Sliders
	  	// Home slider
	  	// Banner services slider
	#Social
		// Youtube or Vimeo video
	#Product grid
		// Show filters
		// Sort by
		// Infinite scroll
  	#Product detail functions
	  	// Installments
	  	// Change Variant
	  	// Product labels on variant change
	  	// Color and size variants change
	  	// Custom mobile variants change
	  	// Submit to contact
	  	// Product slider
	  	// Pinterest sharing
        // Product quantity
  	#Cart
  		// Toggle cart 
  		// Add to cart
  		// Cart quantitiy changes
  		// Empty cart alert
  		// Go to checkout
	#Shipping calculator
		// Select and save shipping function
		// Calculate shipping function
		// Calculate shipping by submit
		// Shipping and branch click
		// Select shipping first option on results
		// Toggle branches link
		// Toggle more shipping options
		// Calculate shipping on page load
		// Shipping provinces
    #Forms
    #Footer
    #Empty placeholders

==============================================================================*/#}

// Move to our_content
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/*============================================================================
  #Lazy load
==============================================================================*/ #}

document.addEventListener('lazybeforeunveil', function(e){
    if ((e.target.parentElement) && (e.target.nextElementSibling)) {
        var parent = e.target.parentElement;
        var sibling = e.target.nextElementSibling;
        if (sibling.classList.contains('js-lazy-loading-preloader')) {
            sibling.style.display = 'none';
            parent.style.display = 'block';
        }
    }
});


window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.4;


DOMContentLoaded.addEventOrExecute(() => {

    {% set add_button_text = settings.add_button_text ? settings.add_button_text : 'Agregar al carrito' | translate %}
    {% set product_button_text = settings.product_button_text ? settings.product_button_text : 'Agregar al carrito' | translate %}
    {% set quantity_variation = ['cantidad','quantidade','quantity'] %}

	{#/*============================================================================
	  #Notifications and tooltips
	==============================================================================*/ #}

    {# /* // Close notification and tooltip */ #}

    jQueryNuvem(".js-notification-close, .js-tooltip-close").on( "click", function(e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).closest(".js-notification, .js-tooltip").hide();
    });

    {# /* // Open tooltip */ #}

    jQueryNuvem(document).on("click", ".js-tooltip-open", function(e) {
        e.preventDefault();
        jQueryNuvem(this).next(".js-tooltip").show();
    });

    {# Notifications variables #}

    
    var $notification_status_page = jQueryNuvem(".js-notification-status-page");
    var $fixed_bottom_button = jQueryNuvem(".js-btn-fixed-bottom");
    var head_height = jQueryNuvem(".js-head-main").height();
    
	{# /* // Follow order status notification */ #}
    
    if ($notification_status_page.length > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){

            $notification_status_page.css("top" , head_height + 15 + "px");
            $notification_status_page.show();
        };
        jQueryNuvem(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    {# /* // Cart notification: Dismiss notification */ #}

    jQueryNuvem(".js-cart-notification-close").on("click", function(){
        jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
            jQueryNuvem(".js-alert-added-to-cart").hide();
        },2000);
    });

    {% if not settings.head_fix_desktop %}

        {# /* // Add to cart notification on non fixed header */ #}
        if (window.innerWidth > 768) {
            var adBarHeight = jQueryNuvem(".js-adbar").outerHeight();
            var logoBarHeight = jQueryNuvem(".js-nav-logo-bar").outerHeight();
            var fixedNotificationPosition = adBarHeight + logoBarHeight + 20; 
            var $addedToCartNotification = jQueryNuvem(".js-alert-added-to-cart");

            $addedToCartNotification.css("top", fixedNotificationPosition.toString() + 'px').css("marginTop", "-1px");

            !function () {
                window.addEventListener("scroll", function (e) {
                    if (window.pageYOffset == 0) {
                        $addedToCartNotification.css("top" , fixedNotificationPosition.toString() + 'px');
                    } else {
                        $addedToCartNotification.css("top" , "30px");
                    }
                });
            }();
        }

    {% endif %}

    {# /* // Add to cart notification position for non fixed header or non tab header mobile  */ #}

    var headLogo = jQueryNuvem(".js-head-logo").outerHeight();
    var contactBar = jQueryNuvem(".js-contactbar").outerHeight();
    var headTopBar = jQueryNuvem(".js-adbar").outerHeight();
    var $addedToCartNotification = jQueryNuvem(".js-alert-added-to-cart");
    var notificationOffset = headLogo + contactBar + headTopBar + 30;

    $addedToCartNotification.css("top" , notificationOffset.toString() + 'px');

    {% if not settings.head_fix_desktop %}

        {# /* // Add to cart notification on non fixed header */ #}

        var topBarHeight = jQueryNuvem(".js-adbar").outerHeight();
        var logoBarHeight = jQueryNuvem(".js-head-logo").outerHeight();
        var searchBarHeight = jQueryNuvem(".js-search-container").outerHeight();
        if (window.innerWidth > 768) {
            var fixedNotificationPosition = topBarHeight + logoBarHeight;
        }else{
            var fixedNotificationPosition = logoBarHeight - searchBarHeight; 
        }
        var $addedToCartNotification = jQueryNuvem(".js-alert-added-to-cart");
        var $addedToCartNotificationArrow = $addedToCartNotification.find(".js-cart-notification-arrow-up");

        $addedToCartNotification.css("top", (fixedNotificationPosition - 10) + "px");

        !function () {
            window.addEventListener("scroll", function (e) {
                if (window.pageYOffset == 0) {
                    $addedToCartNotification.css("top" , fixedNotificationPosition.toString() + 'px');
                    $addedToCartNotificationArrow.css("visibility" , "visible");
                } else {
                    $addedToCartNotification.css("top" , "20px");
                    $addedToCartNotificationArrow.css("visibility" , "hidden");
                }
            });
        }();

    {% endif %}

    {# /* // Quick Login notification */ #}

    {% if not customer and template == 'home' %}

        {# Show quick login messages if it is returning customer #}

        setTimeout(function(){
            if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
                {% if store.country == 'AR' %}
                    jQueryNuvem(".js-quick-login-badge").fadeIn();
                    jQueryNuvem(".js-login-tooltip").show();
                    jQueryNuvem(".js-login-tooltip-desktop").show().addClass("visible");
                {% else %}
                    $quick_login_notification.fadeIn();
                {% endif %}
                return;
            }
            
        },500);

    {% endif %}

    {# Dismiss quick login notifications #}

    jQueryNuvem(".js-dismiss-quicklogin").on( "click", function(e) {
        LS.dontShowQuickLoginNotification();
    });


    setTimeout(function(){
        jQueryNuvem(".js-quick-login-success").fadeOut();
    },8000);
    
    {% if not params.preview %}

        {# /* // Legal footer visibility */ #}

        const footerLegal = jQueryNuvem(".js-footer-legal");

        let footerOffset = 20;

        if (window.innerWidth > 768) {
            footerOffset = 60;
        }

        {% if store.whatsapp %}
            footerLegal.css("paddingBottom", footerOffset + "px");
        {% endif %}

        {# /* // Cookie banner notification */ #}

        restoreNotifications = function(){

            // WhatsApp button position
            if (window.innerWidth < 768) {
                $fixed_bottom_button.css("marginBottom", "10px");
            }

            footerLegal.css("paddingBottom", footerOffset + "px");

        };

        if (!window.cookieNotificationService.isAcknowledged()) {
            jQueryNuvem(".js-notification-cookie-banner").show();

            {# Offset to show legal footer #}
                
            const cookieBannerHeight = jQueryNuvem(".js-notification-cookie-banner").outerHeight();
            footerLegal.css("paddingBottom", cookieBannerHeight + footerOffset + "px");

            {# WhatsApp button position #}

            $fixed_bottom_button.css("marginBottom", "65px");

        }

        jQueryNuvem(".js-acknowledge-cookies").on( "click", function(e) {
            window.cookieNotificationService.acknowledge();

            footerLegal.removeAttr("style");
            restoreNotifications();
        });

    {% endif %}

    {#/*============================================================================
      #Modals
    ==============================================================================*/ #}

    {% if settings.quick_shop %}

        restoreQuickshopForm = function(){

            {# Restore form to item when quickshop closes #}

            {# Clean quickshop modal #}

            jQueryNuvem("#quickshop-modal .js-item-product").removeClass("js-swiper-slide-visible js-item-slide");
            jQueryNuvem("#quickshop-modal .js-quickshop-container").attr( { 'data-variants' : '' , 'data-quickshop-id': '' } );
            jQueryNuvem("#quickshop-modal .js-item-product").attr('data-product-id', '');

            {# Wait for modal to become invisible before removing form #}
            
            setTimeout(function(){
                var $quickshop_form = jQueryNuvem("#quickshop-form").find('.js-product-form');
                var $item_form_container = jQueryNuvem(".js-quickshop-opened").find(".js-item-variants");
                
                $quickshop_form.detach().appendTo($item_form_container);
                jQueryNuvem(".js-quickshop-opened").removeClass("js-quickshop-opened");
                jQueryNuvem("#quickshop-modal .js-quickshop-img").attr('srcset', '');
                jQueryNuvem("#quickshop-form").removeAttr("style");
            },350);
        };

    {% endif %}

    {# Reset al open searches when closing a modal #}

    resetSearchBox = function(){

        {# Reset al open searches when closing a modal #}
        
        jQueryNuvem(".js-search-input").val("");
        jQueryNuvem(".js-search-form-suggestions").hide();

        const empty_search = jQueryNuvem(".js-empty-search");
        const empty_submit = jQueryNuvem(".js-search-input-submit");

        empty_search.fadeOut(100);
        empty_submit.fadeIn(100);

    };

    {# Full screen mobile modals back events #}

    if (window.innerWidth < 768) {

        {# Clean url hash function #}

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        {# Go back 1 step on browser history #}

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        {# Clean url hash on page load: All modals should be closed on load #}

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        {# Open full screen modal and url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = jQueryNuvem(this).data("modalUrl");
            window.location.hash = modal_url_hash;
        });

        {# Close full screen modal: Remove url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {

                {# Close opened modal #}

                if(jQueryNuvem(".js-fullscreen-modal").hasClass("modal-show")){

                    {# Remove body lock only if a single modal is visible on screen #}

                    if(jQueryNuvem(".js-modal.modal-show").length == 1){
                        jQueryNuvem("body").removeClass("overflow-none");
                    }
                    var $opened_modal = jQueryNuvem(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();

                    $opened_modal.removeClass("modal-show");
                    setTimeout(() => $opened_modal.hide(), 500);
                    $opened_modal_overlay.fadeOut(500);

                    {# Reset al open searches when closing a modal #}
        
                    resetSearchBox();

                    {% if settings.quick_shop %}
                        restoreQuickshopForm();
                    {% endif %}

                }
            }
        }

    }

    modalOpen = function(modal_id){

        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="' + modal_id + '"]');

        if (jQueryNuvem(modal_id).hasClass("modal-show")) {
            {# If modal is already opened, close it #}
            if(jQueryNuvem(".js-modal.modal-show").length == 1){
                jQueryNuvem("body").removeClass("overflow-none");
            }
            let modal = jQueryNuvem(modal_id).removeClass("modal-show");
            setTimeout(() => modal.hide(), 500);
        } else {

            {# Lock body scroll if there is no modal visible on screen #}
            
            if(!jQueryNuvem(".js-modal.modal-show").length){
                jQueryNuvem("body").addClass("overflow-none move-right");
            }

            jQueryNuvem(modal_id).detach().appendTo("body");
            jQueryNuvem(modal_id).show().addClass("modal-show");
            
            {# Show overlay for all modals or tab modals only in desktop #}
            if (((jQueryNuvem(modal_id).hasClass("js-modal-overlay-md")) && (window.innerWidth > 768)) || (!jQueryNuvem(modal_id).hasClass("js-modal-overlay-md"))) {
                $overlay_id.fadeIn(400);
                $overlay_id.detach().insertBefore(modal_id);
            }
        }

    };

    jQueryNuvem(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault(); 
        const modal_id = jQueryNuvem(this).data('toggle');
        modalOpen(modal_id);
    });

    jQueryNuvem(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var $modal = jQueryNuvem(this).closest(".js-modal");
        var modal_id = $modal.attr('id');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="#' + modal_id + '"]');
        $modal.removeClass("modal-show");
        setTimeout(() => $modal.hide(), 500);
        $overlay_id.fadeOut(500);

        {# Close full screen modal: Remove url hash #}

        if ((window.innerWidth < 768) && (jQueryNuvem(this).hasClass(".js-fullscreen-modal-close"))) {
            goBackBrowser();
        }

        {# Reset al open searches when closing a modal #}

        resetSearchBox();

        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

    });

    jQueryNuvem(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }

        var modal_id = jQueryNuvem(this).data('modalId');
        let modal = jQueryNuvem(modal_id).removeClass("modal-show");
        setTimeout(() => modal.hide(), 500);
        jQueryNuvem(this).fadeOut(500);

        {# Reset al open searches when closing a modal #}
        
        resetSearchBox();

        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

    });

    {% if template == 'home' and settings.show_news_box %}

        {# /* // Home popup and newsletter popup */ #}

        jQueryNuvem('#news-popup-form').on("submit", function () {
            jQueryNuvem(".js-news-spinner").show();
            jQueryNuvem(".js-news-send, .js-news-popup-submit").hide();
            jQueryNuvem(".js-news-popup-submit").prop("disabled", true);
        });

        LS.newsletter('#news-popup-form-container', '#home-modal', '{{ store.contact_url | escape('js') }}', function (response) {
            jQueryNuvem(".js-news-spinner").hide();
            jQueryNuvem(".js-news-send, .js-news-popup-submit").show();
            var selector_to_use = response.success ? '.js-news-popup-success' : '.js-news-popup-failed';
            let newPopupAlert = jQueryNuvem(this).find(selector_to_use).fadeIn(100);
            setTimeout(() => newPopupAlert.fadeOut(500), 4000);
            if (jQueryNuvem(".js-news-popup-success").css("display") == "block") {
                setTimeout(function () {
                    jQueryNuvem('[data-modal-id="#home-modal"]').fadeOut(500);
                    let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
                    setTimeout(() => homeModal.hide(), 500);
                }, 2500);
            }
            jQueryNuvem(".js-news-popup-submit").prop("disabled", false);
        });

        {# Foco do pop-up: vai para o botao Fechar ao abrir, fica preso no pop-up, Esc fecha e o foco volta ao fim #}
        var homePopupFocus = (function () {
            var previous = null;
            var observer = null;
            var getModal = function () { return document.getElementById('home-modal'); };
            var getFocusables = function (modal) {
                return Array.prototype.filter.call(
                    modal.querySelectorAll('a[href], button:not([disabled]), input:not([disabled]):not([type="hidden"]), select, textarea, [tabindex]:not([tabindex="-1"])'),
                    function (el) { return el.offsetParent !== null; }
                );
            };
            var onKeydown = function (e) {
                var modal = getModal();
                if (!modal || !modal.classList.contains('modal-show')) { return; }
                if (e.key === 'Escape' || e.key === 'Esc') {
                    var close = modal.querySelector('button.js-modal-close');
                    if (close) { e.preventDefault(); close.click(); }
                    return;
                }
                if (e.key !== 'Tab') { return; }
                var items = getFocusables(modal);
                if (!items.length) { return; }
                var first = items[0];
                var last = items[items.length - 1];
                if (!modal.contains(document.activeElement)) {
                    e.preventDefault();
                    first.focus();
                } else if (e.shiftKey && document.activeElement === first) {
                    e.preventDefault();
                    last.focus();
                } else if (!e.shiftKey && document.activeElement === last) {
                    e.preventDefault();
                    first.focus();
                }
            };
            return {
                open: function () {
                    var modal = getModal();
                    if (!modal) { return; }
                    previous = document.activeElement;
                    var close = modal.querySelector('button.js-modal-close');
                    if (close) { close.focus(); }
                    document.addEventListener('keydown', onKeydown);
                    if (observer) { observer.disconnect(); }
                    observer = new MutationObserver(function () {
                        if (modal.classList.contains('modal-show')) { return; }
                        observer.disconnect();
                        document.removeEventListener('keydown', onKeydown);
                        if (previous && document.contains(previous) && previous.focus) { previous.focus(); }
                        previous = null;
                    });
                    observer.observe(modal, { attributes: true, attributeFilter: ['class'] });
                }
            };
        })();

        var callback_show = function(){
            jQueryNuvem('.js-modal-overlay[data-modal-id="#home-modal"]').fadeIn(500);
            jQueryNuvem("#home-modal").detach().appendTo("body").show().addClass("modal-show");
            homePopupFocus.open();
        }
        var callback_hide = function(){
            jQueryNuvem('.js-modal-overlay[data-modal-id="#home-modal"]').fadeOut(500);
            let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
            setTimeout(() => homeModal.hide(), 500);
        }
        LS.homePopup({
            selector: "#home-modal",
            timeout: 6000,
            mobile_max_pixels: 0,
            cookie_expiration_days: {{ settings.home_popup_cookie ? settings.home_popup_cookie : 15 }},
        }, callback_hide, callback_show);

    {% endif %}

    {#/*============================================================================
      #Cards
    ==============================================================================*/ #}
    jQueryNuvem(document).on("click", ".js-card-collapse-toggle", function(e) {
        e.preventDefault();
        var parent = jQueryNuvem(this).closest(".js-card-collapse");
        parent.find(".js-card-collapse-icon").toggle();
        parent.toggleClass('active');
    });    

    {#/*============================================================================
      #Tabs
    ==============================================================================*/ #}

    var $tab_open = jQueryNuvem('.js-tab');

    $tab_open.on("click", function (e) {
        e.preventDefault(); 
        var $tab_container = jQueryNuvem(e.currentTarget).closest(".js-tab-container");
        $tab_container.find(".js-tab, .js-tab-panel").removeClass("active");
        jQueryNuvem(e.currentTarget).addClass("active");
        var tab_to_show = jQueryNuvem(e.currentTarget).find(".js-tab-link").attr("href");
        $tab_container.find(tab_to_show).addClass("active");    
    });

    {#/*============================================================================
      #Accordions
    ==============================================================================*/ #}

    function toggleAccordion(selector){
        if(jQueryNuvem(selector).hasClass("js-accordion-show-only")){
            jQueryNuvem(selector).hide();
        }else{
            jQueryNuvem(selector).find(".js-accordion-toggle-inactive").toggle();
            jQueryNuvem(selector).find(".js-accordion-toggle-active").toggle();
        }
        jQueryNuvem(selector).closest(".js-accordion-container").find(".js-accordion-content").slideToggle("fast");
    }

    jQueryNuvem(document).on("click", ".js-accordion-toggle", function(e) {
        e.preventDefault();
        toggleAccordion(this);
    });

    if(window.innerWidth < 768){
        jQueryNuvem(document).on("click", ".js-accordion-toggle-mobile", function(e) {
            e.preventDefault();
            toggleAccordion(this);
        });
        jQueryNuvem(".js-accordion-content-mobile").hide();
    }else{
        jQueryNuvem(".js-accordion-toggle-mobile").css("cursor" , "default").removeAttr('href');
    }

    {#/*============================================================================
      #Transitions
    ==============================================================================*/ #}

    const inViewport = (entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting && !entry.target.observed) {
          entry.target.classList.add("is-inViewport");
          entry.target.observed = true;
        }
      });
    };

    // Attach observer to every [data-transition] element:
    const ELs_inViewport = document.querySelectorAll('[data-transition]');
    ELs_inViewport.forEach(EL => {
      EL.observed = false; // Initialize the observed flag for each element
      const Obs = new IntersectionObserver(inViewport);
      Obs.observe(EL);
    });

    applyMarqueeAnimation = function(marqueeSelector, textSelector){

        {# Reference speed values #}

        var defaultDelay = 5;
        var defaultWidth = 300;

        {# New speed values based on dynamic content #}
        var animatedWidth = jQueryNuvem(textSelector).first(el => el.offsetWidth);
        var newDelay = defaultDelay*(animatedWidth/defaultWidth)*1.5;

        if((window.innerWidth > 768) && (newDelay < 40)){

            {# If content is too short, set a minimum speed #}
            var newDelay = newDelay + 20;
        }

        jQueryNuvem(marqueeSelector).css("animation", "marquee " + newDelay + "s linear infinite");
    };
        
	{#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Adbar slider */ #}

    {% set num_ads = 0 %}
    {% set has_ad_bar_01 = settings.ad_bar_01_text %}
    {% set has_ad_bar_02 = settings.ad_bar_02_text %}
    {% set has_ad_bar_03 = settings.ad_bar_03_text %}
    {% set has_ad_bar_04 = settings.ad_bar_04_text %}

    {% for adbar in ['ad_bar_01', 'ad_bar_02', 'ad_bar_03', 'ad_bar_04'] %}
        {% set ad_text = attribute(settings,"#{adbar}_text") %}
        {% if ad_text %}
            {% set num_ads = num_ads + 1 %}
        {% endif %}
    {% endfor %}

    {% set adbar_effect = settings.adbar_carousel ? (settings.adbar_animation_type ?: 'carousel') : 'none' %}

    {% if settings.adbar_carousel and settings.adbar_animation_type == "marquee" %}

        {# /* // Animated adbar */ #}

        applyMarqueeAnimation(".js-adbar-animated" , ".js-adbar-text-container");

    {% elseif num_ads > 1  %}

        var width = window.innerWidth;
        createSwiper('.js-swiper-adbar', {
            loop: true,
            watchOverflow: true,
            autoplay: true,
            centerInsufficientSlides: true,
            centeredSlides: true,
            threshold: 5,
            slidesPerView: 1,
            navigation: {
                nextEl: '.js-swiper-adbar-next',
                prevEl: '.js-swiper-adbar-prev',
            },
            breakpointsInverse: true,
            breakpoints: {
                768: {
                    loop: true,
                    slidesPerView: {% if adbar_effect == 'carousel' %}1{% else %}2{% endif %},
                    centeredSlides: false,
                },
                992: {
                    {% if num_ads < 4 %}
                    loop: false,
                    autoplay: false,
                    {% endif %}
                    slidesPerView: {% if adbar_effect == 'carousel' %}1{% else %}3{% endif %},
                    centeredSlides: false,
                },
                1199: {
                    {% if adbar_effect == 'none' %}
                    autoplay: false,
                    loop: false,
    	            {% endif %}
                    slidesPerView: {% if adbar_effect == 'carousel' %}1{% else %}{{ num_ads }}{% endif %},
                    centeredSlides: false,
                }
            }
        });

    {% endif %}

    {# Focus search #}

    const search_input = jQueryNuvem(".js-search-input");

    jQueryNuvem(".js-search-button").on("click", function (e) {
        setTimeout(function(){
            search_input.val('').each(el => el.focus());
        },10);
    });    

    {# /* // Header */ #}

        {# /* // Nav offset */ #}

        function applyOffset(selector){

            {% if not settings.head_transparent %}

            // Get nav height on load
            if (window.innerWidth > 768) {
                var head_height = jQueryNuvem(".js-head-main").height();
                jQueryNuvem(selector).css("paddingTop", head_height.toString() + 'px');
            }else{

                {# On mobile there is no top padding due to position sticky CSS #}
                var head_height = 0;
            }

            // Apply offset nav height on load

            window.addEventListener("resize", function() {

                // Get nav height on resize
                var head_height = jQueryNuvem(".js-head-main").height();

                // Apply offset on resize
                if (window.innerWidth > 768) {
                    jQueryNuvem(selector).css("paddingTop", head_height.toString() + 'px');
                }else{

                    {# On mobile there is no top padding due to position sticky CSS #}
                    jQueryNuvem(selector).css("paddingTop", "0px");
                }
            });

            {% endif %}
        }

        {% if settings.head_fix_desktop and ((settings.head_transparent and template != 'home') or (not settings.head_transparent)) %}
            applyOffset(".js-head-offset");
        {% endif %}


        {% if settings.head_fix_desktop %}

            var lastScrollTop = 0;
            window.addEventListener("scroll", function(event){
               var infos_row_height = jQueryNuvem(".js-contact-bar").height();
               var head_main_height = jQueryNuvem(".js-head-main").height();
               var head_logo_height = jQueryNuvem(".js-head-logo").height();
               var head_fixed_height = jQueryNuvem(".js-head-fixed").height();
               var head_ad_height = jQueryNuvem(".js-adbar").height();
               var scrollPosition = window.pageYOffset;
               if (scrollPosition > lastScrollTop && scrollPosition > (head_ad_height+head_main_height)){
                  jQueryNuvem(".header-fixed").addClass('is-fixed');
                  if (window.innerWidth < 768) {
                    jQueryNuvem(".js-alert-added-to-cart").css("top" , "15px");
                  } else {
                    jQueryNuvem(".js-alert-added-to-cart").css("top" , (head_fixed_height + 5).toString() + 'px');
                  }
               } else {
                  jQueryNuvem(".header-fixed").removeClass('is-fixed');
                  if (scrollPosition == 0) {
                    jQueryNuvem(".js-alert-added-to-cart").css("top" , (head_ad_height+head_main_height).toString() + 'px');
                  } else {
                    jQueryNuvem(".js-alert-added-to-cart").css("top" , "25px");
                  }
               }

               lastScrollTop = scrollPosition;
            });
            
        {% endif %}

        var container_width = jQueryNuvem(".js-head-logo").width();
        if (window.innerWidth > 768) {
            jQueryNuvem('.js-alert-added-to-cart').css("right", (jQueryNuvem('body').width() - container_width) / 2 - 25 + "px");
        }

        {# /* // Utilities */ #}

        jQueryNuvem(".js-utilities-item").on("mouseenter", function (e) {
            e.preventDefault();
            jQueryNuvem(e.currentTarget).toggleClass("active");
        }).on("mouseleave", function(e) {
            e.preventDefault();
            jQueryNuvem(e.currentTarget).toggleClass("active");
        });


        {# /* // Nav */ #}

        var $top_nav = jQueryNuvem(".js-mobile-nav");
        var $page_main_content = jQueryNuvem(".js-main-content");
        var $search_backdrop = jQueryNuvem(".js-search-backdrop");

        $top_nav.addClass("move-down").removeClass("move-up");


        {# Nav subitems #}

        jQueryNuvem(".js-toggle-page-accordion").on("click", function (e) {
            e.preventDefault();
            jQueryNuvem(e.currentTarget).toggleClass("active").closest(".js-nav-list-toggle-accordion").next(".js-pages-accordion").slideToggle(300);
        });

        var win_height = window.innerHeight;
        var head_height = jQueryNuvem(".js-head-main").height();

        jQueryNuvem(".js-desktop-dropdown").css('maxHeight', (win_height - head_height - 50).toString() + 'px');

        jQueryNuvem(".js-item-subitems-desktop").on("mouseenter", function (e) {

            var $currentTarget = jQueryNuvem(e.currentTarget);
            var elementPositionX = $currentTarget.offset().left;
            var elementPositionY = $currentTarget.offset().top;
            var elementHeight = $currentTarget.height();
            var windowWidth =  window.innerWidth;
            var halfWindowWidth = windowWidth / 2;

            {% if settings.menu_design == 'full' %}
                {% if settings.head_style == 'style3' or settings.head_style == 'style5' %}
                    if (elementPositionY > 0) {
                        $currentTarget.find('.js-desktop-dropdown').css('top', elementHeight + 'px');
                    }
                {% else %}
                    if (elementPositionY > 0) {
                        $currentTarget.find('.js-desktop-dropdown').css('top', (elementPositionY + elementHeight).toString() + 'px');
                    }
                {% endif %}
            {% endif %}

            var openToLeft = elementPositionX > halfWindowWidth;

            if (openToLeft) {
                $currentTarget.find('.desktop-dropdown').addClass("open-left");
                $currentTarget.find('.arrow-left').removeClass('hidden');
                $currentTarget.find('.arrow-right').addClass('hidden');
            } else {
                $currentTarget.find('.desktop-dropdown').addClass("open-right");
                $currentTarget.find('.arrow-right').removeClass('hidden');
                $currentTarget.find('.arrow-left').addClass('hidden');
            }

            jQueryNuvem(e.currentTarget).addClass("active");
            jQueryNuvem(".js-menu-overlay").addClass('active');

        }).on("mouseleave", function(e) {
            jQueryNuvem(e.currentTarget).removeClass("active");
            jQueryNuvem(".js-menu-overlay").removeClass('active');
        });

        jQueryNuvem(".js-nav-main-item").on("mouseenter", function (e) {
            jQueryNuvem('.js-nav-desktop-list').children(".selected").removeClass("selected");
            jQueryNuvem(e.currentTarget).addClass("selected");
        });

        jQueryNuvem(".js-nav-desktop-list-arrow").on("mouseenter", function (e) {
            jQueryNuvem('.js-desktop-nav-item').removeClass("selected");
        });   


    {# /* // Lang select */ #}

    changeLang = function(element) {
        var selected_country_url = element.find("option").filter((el) => el.selected).attr("data-country-url");
        location.href = selected_country_url;
    };

    jQueryNuvem('.js-lang-select').on("change", function (e) {
        lang_select_option = jQueryNuvem(this);

        changeLang(lang_select_option);
    });

	{#/*============================================================================
	  #Sliders
	==============================================================================*/ #}

    {% set theme_editor = params.preview %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    var slidesPerViewDesktopVal = {% if columns_desktop == 5 %}5{% else %}4{% endif %};
    var slidesPerViewMobileVal = {% if columns_mobile == 1 %}1.5{% else %}2.25{% endif %};
    var itemSwiperSpaceBetween = 10;
    {% if settings.item_borders %}
        var itemDesktopSpaceBetween = 20;
    {% else %}
        var itemDesktopSpaceBetween = 10;
    {% endif %}

    {# Hide arrow controls when swiper is not swipable #}

    hideSwiperControls = function(elemPrev, elemNext) {
        if((jQueryNuvem(elemPrev).hasClass("swiper-button-disabled") && jQueryNuvem(elemNext).hasClass("swiper-button-disabled"))){
            jQueryNuvem(elemPrev).remove();
            jQueryNuvem(elemNext).remove();
        }
    };

	{% if template == 'home' %}

		{# /* // Home slider */ #}

        {% if settings.slider_speed %}
            {% set slider_speed = settings.slider_speed ~ '000' %}
        {% else %}
            {% set slider_speed = '6000' %}
        {% endif %}

        var width = window.innerWidth;
        var slider_autoplay = {
            delay: {{ slider_speed }},
        };

        window.homeSlider = {
            getAutoRotation: function() {
                return slider_autoplay;
            },
            updateSlides: function(slides) {
                homeSwiper.removeAllSlides();
                slides.forEach(function(aSlide){
                    homeSwiper.appendSlide(
                        '<div class="swiper-slide slide-container ' + aSlide.color + '">' +
                            (aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
                                '<img src="' + aSlide.src + '" class="slider-image"/>' +
                                '<div class="swiper-text{% if settings.slider_align == 'center' %} swiper-text-centered{% endif %} swiper-text-' + aSlide.color + '">' +
                                    (aSlide.description ? '<p class="mb-3">' + aSlide.description + '</p>' : '' ) +
                                    (aSlide.title ? '<div class="h1-huge mb-3">' + aSlide.title + '</div>' : '' ) +
                                    (aSlide.button && aSlide.link ? '<div class="btn btn-default btn-small d-inline-block">' + aSlide.button + '</div>' : '' ) +
                                '</div>' +
                            (aSlide.link ? '</a>' : '' ) +
                        '</div>'
                    );
                });

                {% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}

                if(!slides.length){
                    jQueryNuvem(".js-home-main-slider-container").addClass("hidden");
                    jQueryNuvem(".js-home-empty-slider-container").removeClass("hidden");
                    jQueryNuvem(".js-home-mobile-slider-visibility").removeClass("d-md-none");
                    {% if has_mobile_slider %}
                        jQueryNuvem(".js-home-main-slider-visibility").removeClass("d-none d-md-block");
                        homeMobileSwiper.update();
                    {% endif %}
                }else{
                    jQueryNuvem(".js-home-main-slider-container").removeClass("hidden");
                    jQueryNuvem(".js-home-empty-slider-container").addClass("hidden");
                    jQueryNuvem(".js-home-mobile-slider-visibility").addClass("d-md-none");
                    {% if has_mobile_slider %}
                        jQueryNuvem(".js-home-main-slider-visibility").addClass("d-none d-md-block");
                    {% endif %}
                }
            },
            changeAutoRotation: function(){

            },
        };

        var preloadImagesValue = false;
        var lazyValue = { loadPrevNext: true, loadPrevNextAmount: 1, loadOnTransitionStart: true };
        var loopValue = true;
        var paginationClickableValue = true;

        var homeSwiper = null;
        createSwiper(
            '.js-home-slider', {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                {% if settings.slider_effect == "fade" %}
                    effect: "fade",
                {% endif %}
                autoplay: slider_autoplay,
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
            },
            function(swiperInstance) {
                homeSwiper = swiperInstance;
            }
        );

        var homeMobileSwiper = null;
        createSwiper(
            '.js-home-slider-mobile', {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider_mobile | length > 1 %}
                    loop: loopValue,
                {% endif %}
                {% if settings.slider_effect == "fade" %}
                    effect: "fade",
                {% endif %}
                autoplay: slider_autoplay,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
            },
            function(swiperInstance) {
                homeMobileSwiper = swiperInstance;
            }
        );

        {% if settings.slider | length == 1 %}
            jQueryNuvem('.js-swiper-home .swiper-wrapper').addClass( "disabled" );
            jQueryNuvem('.js-swiper-home-pagination, .js-swiper-home-prev, .js-swiper-home-next').remove();
        {% endif %}

        {# /* // Banner services slider */ #}

        {% set has_banner_services = settings.banner_services %}

        {% if has_banner_services and settings.banner_services_mobile_format == "slider" %}

            var width = window.innerWidth;
            if (width < 767) {   
                createSwiper('.js-informative-banners', {
                    autoplay: true,
                    speed: 1600,
                    navigation: {
                        nextEl: '.js-informative-banners-next',
                        prevEl: '.js-informative-banners-prev',
                    },
                });
            }

        {% endif %}

    {% endif %}

    {% if template == 'home' or template == 'search' or template == 'category' %}

        {% set has_featured_products_slider = sections.primary.products and (settings.featured_products_format_mobile == 'slider' or settings.featured_products_format_desktop == 'slider') %}

        {% if has_featured_products_slider %}

            var lazyVal = true;
            var watchOverflowVal = true;
            var centerInsufficientSlidesVal = true;

            {% set featured_desktop_slider = settings.featured_products_format_desktop == 'slider' %}
            {% set featured_only_mobile_slider = settings.featured_products_format_mobile == 'slider' and settings.featured_products_format_desktop != 'slider' %}
            {% set featured_only_desktop_slider = settings.featured_products_format_desktop == 'slider' and settings.featured_products_format_mobile != 'slider' %}
            {% set featured_columns_desktop = settings.featured_products_desktop %}
            {% set featured_columns_mobile = settings.featured_products_mobile %}
            var slidesPerViewFeaturedDesktopVal = {% if featured_columns_desktop == 3 %}3{% elseif featured_columns_desktop == 4 %}4{% elseif featured_columns_desktop == 5 %}5{% else %}6{% endif %};
            var slidesPerViewFeaturedMobileVal = {% if featured_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};

            {% if settings.featured_products_scroll_quantity == "all" %}
                var slidesPerGroupFeaturedDesktopVal = slidesPerViewFeaturedDesktopVal;
            {% else %}
                var slidesPerGroupFeaturedDesktopVal = 1;
            {% endif %}

            {% if settings.featured_products_autoplay %}
                var autoplayFeaturedVal = {delay: 6000,}
            {% else %}
                var autoplayFeaturedVal = false;
            {% endif %}

            {% if featured_only_mobile_slider %}
                if (window.innerWidth < 768) {
            {% elseif featured_only_desktop_slider %}
                if (window.innerWidth > 768) {
            {% endif %}
                window.swiperLoader('.js-swiper-featured', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    centerInsufficientSlides: centerInsufficientSlidesVal,
                    threshold: 5,
                    autoplay: autoplayFeaturedVal,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: itemSwiperSpaceBetween,
                {% if sections.primary.products | length > 4 %}
                    loop: true,
                {% endif %}
                    navigation: {
                        nextEl: '.js-swiper-featured-next',
                        prevEl: '.js-swiper-featured-prev',
                    },
                    {% if settings.featured_products_pagination %}
                        pagination: {
                            el: '.js-swiper-featured-pagination',
                        },
                    {% endif %}                    
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-featured-prev", ".js-swiper-featured-next");
                        },
                    },
                    slidesPerView: slidesPerViewFeaturedMobileVal,
                {% if featured_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: slidesPerViewFeaturedDesktopVal,
                            slidesPerGroup: slidesPerGroupFeaturedDesktopVal,
                            spaceBetween: itemDesktopSpaceBetween,
                        }
                    }
                {% endif %}
                });
            {% if featured_only_mobile_slider or featured_only_desktop_slider %}
                }
            {% endif %}

        {% endif %}

    {% endif %}

    {% if template == 'home' or template == 'category' %}

        {# /* // Products slider */ #}

        {% set has_new_products_slider = sections.new.products and (settings.new_products_format_mobile == 'slider' or settings.new_products_format_desktop == 'slider') %}
        {% set has_sale_products_slider = sections.sale.products and (settings.sale_products_format_mobile == 'slider' or settings.sale_products_format_desktop == 'slider') %}
        {% set has_promotion_products_slider = sections.promotion.products and (settings.promotion_products_format_mobile == 'slider' or settings.promotion_products_format_desktop == 'slider') %}
        {% set has_best_seller_products_slider = sections.best_seller.products and (settings.best_seller_products_format_mobile == 'slider' or settings.best_seller_products_format_desktop == 'slider') %}
        {% set has_selection_products_slider = sections.selection.products %}

        {% if has_new_products_slider or has_sale_products_slider or has_promotion_products_slider or has_best_seller_products_slider or has_selection_products_slider %}

            var lazyVal = true;
            var watchOverflowVal = true;
            var centerInsufficientSlidesVal = true;

            {% if has_new_products_slider %}

                {% set new_desktop_slider = settings.new_products_format_desktop == 'slider' %}
                {% set new_only_mobile_slider = settings.new_products_format_mobile == 'slider' and settings.new_products_format_desktop != 'slider' %}
                {% set new_only_desktop_slider = settings.new_products_format_desktop == 'slider' and settings.new_products_format_mobile != 'slider' %}
                {% set new_columns_desktop = settings.new_products_desktop %}
                {% set new_columns_mobile = settings.new_products_mobile %}
                var slidesPerViewNewDesktopVal = {% if new_columns_desktop == 3 %}3{% elseif new_columns_desktop == 4 %}4{% elseif new_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewNewMobileVal = {% if new_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};

                {% if settings.new_products_autoplay %}
                    var autoplayNewVal = {delay: 6000,}
                {% else %}
                    var autoplayNewVal = false;
                {% endif %}

                {% if settings.new_products_scroll_quantity == "all" %}
                    var slidesPerGroupNewDesktopVal = slidesPerViewNewDesktopVal;
                {% else %}
                    var slidesPerGroupNewDesktopVal = 1;
                {% endif %}

                {% if new_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif new_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    window.swiperLoader('.js-swiper-new', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        autoplay: autoplayNewVal,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.new.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-new-next',
                            prevEl: '.js-swiper-new-prev',
                        },
                        {% if settings.new_products_pagination %}
                            pagination: {
                                el: '.js-swiper-new-pagination',
                            },
                        {% endif %}
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-new-prev", ".js-swiper-new-next");
                            },
                        },
                    slidesPerView: slidesPerViewNewMobileVal,
                    {% if new_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewNewDesktopVal,
                                slidesPerGroup: slidesPerGroupNewDesktopVal,
                                spaceBetween: itemDesktopSpaceBetween,
                            }
                        }
                    {% endif %}
                    });
                {% if new_only_mobile_slider or new_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if has_sale_products_slider %}

                {% set sale_desktop_slider = settings.sale_products_format_desktop == 'slider' %}
                {% set sale_only_mobile_slider = settings.sale_products_format_mobile == 'slider' and settings.sale_products_format_desktop != 'slider' %}
                {% set sale_only_desktop_slider = settings.sale_products_format_desktop == 'slider' and settings.sale_products_format_mobile != 'slider' %}
                {% set sale_columns_desktop = settings.sale_products_desktop %}
                {% set sale_columns_mobile = settings.sale_products_mobile %}
                var slidesPerViewSaleDesktopVal = {% if sale_columns_desktop == 3 %}3{% elseif sale_columns_desktop == 4 %}4{% elseif sale_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewSaleMobileVal = {% if sale_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};

                {% if settings.sale_products_scroll_quantity == "all" %}
                    var slidesPerGroupSaleDesktopVal = slidesPerViewSaleDesktopVal;
                {% else %}
                    var slidesPerGroupSaleDesktopVal = 1;
                {% endif %}

                {% if settings.sale_products_autoplay %}
                    var autoplaySaleVal = {delay: 6000,}
                {% else %}
                    var autoplaySaleVal = false;
                {% endif %}

                {% if sale_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif sale_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    window.swiperLoader('.js-swiper-sale', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        autoplay: autoplaySaleVal,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.sale.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-sale-next',
                            prevEl: '.js-swiper-sale-prev',
                        },
                        {% if settings.sale_products_pagination %}
                            pagination: {
                                el: '.js-swiper-sale-pagination',
                            },
                        {% endif %}
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-sale-prev", ".js-swiper-sale-next");
                            },
                        },
                        slidesPerView: slidesPerViewSaleMobileVal,
                    {% if sale_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewSaleDesktopVal,
                                slidesPerGroup: slidesPerGroupSaleDesktopVal,
                                spaceBetween: itemDesktopSpaceBetween,
                            }
                        }
                    {% endif %}
                    });
                {% if sale_only_mobile_slider or sale_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if has_promotion_products_slider %}

                {% set promotion_desktop_slider = settings.promotion_products_format_desktop == 'slider' %}
                {% set promotion_only_mobile_slider = settings.promotion_products_format_mobile == 'slider' and settings.promotion_products_format_desktop != 'slider' %}
                {% set promotion_only_desktop_slider = settings.promotion_products_format_desktop == 'slider' and settings.promotion_products_format_mobile != 'slider' %}
                {% set promotion_columns_desktop = settings.promotion_products_desktop %}
                {% set promotion_columns_mobile = settings.promotion_products_mobile %}
                var slidesPerViewPromotionDesktopVal = {% if promotion_columns_desktop == 3 %}3{% elseif promotion_columns_desktop == 4 %}4{% elseif promotion_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewPromotionMobileVal = {% if promotion_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};

                {% if settings.promotion_products_scroll_quantity == "all" %}
                    var slidesPerGroupPromotionDesktopVal = slidesPerViewPromotionDesktopVal;
                {% else %}
                    var slidesPerGroupPromotionDesktopVal = 1;
                {% endif %}

                {% if settings.promotion_products_autoplay %}
                    var autoplayPromotionVal = {delay: 6000,}
                {% else %}
                    var autoplayPromotionVal = false;
                {% endif %}

                {% if promotion_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif promotion_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    window.swiperLoader('.js-swiper-promotion', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        autoplay: autoplayPromotionVal,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.promotion.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-promotion-next',
                            prevEl: '.js-swiper-promotion-prev',
                        },
                        {% if settings.promotion_products_pagination %}
                            pagination: {
                                el: '.js-swiper-promotion-pagination',
                            },
                        {% endif %}
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-promotion-prev", ".js-swiper-promotion-next");
                            },
                        },
                        slidesPerView: slidesPerViewPromotionMobileVal,
                    {% if promotion_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewPromotionDesktopVal,
                                slidesPerGroup: slidesPerGroupPromotionDesktopVal,
                                spaceBetween: itemDesktopSpaceBetween,
                            }
                        }
                    {% endif %}
                    });
                {% if promotion_only_mobile_slider or promotion_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if has_best_seller_products_slider %}

                {% set best_seller_desktop_slider = settings.best_seller_products_format_desktop == 'slider' %}
                {% set best_seller_only_mobile_slider = settings.best_seller_products_format_mobile == 'slider' and settings.best_seller_products_format_desktop != 'slider' %}
                {% set best_seller_only_desktop_slider = settings.best_seller_products_format_desktop == 'slider' and settings.best_seller_products_format_mobile != 'slider' %}
                {% set best_seller_columns_desktop = settings.best_seller_products_desktop %}
                {% set best_seller_columns_mobile = settings.best_seller_products_mobile %}
                var slidesPerViewBestSellerDesktopVal = {% if best_seller_columns_desktop == 3 %}3{% elseif best_seller_columns_desktop == 4 %}4{% elseif best_seller_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewBestSellerMobileVal = {% if best_seller_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};

                {% if settings.best_seller_products_scroll_quantity == "all" %}
                    var slidesPerGroupBestSellerDesktopVal = slidesPerViewBestSellerDesktopVal;
                {% else %}
                    var slidesPerGroupBestSellerDesktopVal = 1;
                {% endif %}

                {% if settings.best_seller_products_autoplay %}
                    var autoplayBestSellerVal = {delay: 6000,}
                {% else %}
                    var autoplayBestSellerVal = false;
                {% endif %}

                {% if best_seller_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif best_seller_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    window.swiperLoader('.js-swiper-best-seller', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        autoplay: autoplayBestSellerVal,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.best_seller.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-best-seller-next',
                            prevEl: '.js-swiper-best-seller-prev',
                        },
                        {% if settings.best_seller_products_pagination %}
                            pagination: {
                                el: '.js-swiper-best-seller-pagination',
                            },
                        {% endif %}
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-best-seller-prev", ".js-swiper-best-seller-next");
                            },
                        },
                        slidesPerView: slidesPerViewBestSellerMobileVal,
                    {% if best_seller_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewBestSellerDesktopVal,
                                slidesPerGroup: slidesPerGroupBestSellerDesktopVal,
                                spaceBetween: itemDesktopSpaceBetween,
                            }
                        }
                    {% endif %}
                    });
                {% if best_seller_only_mobile_slider or best_seller_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if sections.selection.products %}

                {% set sections_products = sections.selection.products %}
                {% set banner_products_columns_mobile = settings.banner_products_mobile %}
                {% set banner_products_columns_desktop = settings.banner_products_columns %}
                var slidesPerViewSelectionMobileVal = {% if banner_products_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};
                var slidesPerViewSelectionDesktopVal = {% if banner_products_columns_desktop == 2 %}2{% elseif banner_products_columns_desktop == 4 %}4{% else %}3{% endif %};
                
                {% if settings.banner_products_autoplay %}
                    var autoplayBannerProductsVal = {delay: 6000,}
                {% else %}
                    var autoplayBannerProductsVal = false;
                {% endif %}

                window.swiperLoader('.js-swiper-promos', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    centeredSlides: false,
                    centerInsufficientSlides: centerInsufficientSlidesVal,
                    spaceBetween: itemSwiperSpaceBetween,
                    threshold: 5,
                    autoplay: autoplayBannerProductsVal,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    {% if sections_products | length > 3 %}
                        loop: true,
                    {% endif %}
                    navigation: {
                        nextEl: '.js-swiper-promos-next',
                        prevEl: '.js-swiper-promos-prev',
                    },
                    {% if settings.banner_products_pagination %}
                        pagination: {
                            el: '.js-swiper-promos-pagination',
                        },
                    {% endif %}
                    slidesPerView: slidesPerViewSelectionMobileVal,
                    breakpointsInverse: slidesPerViewSelectionMobileVal,
                    breakpoints: {
                        768: {
                            slidesPerView: slidesPerViewSelectionMobileVal,
                            {% if settings.banner_products_scroll_quantity == "all" %}
                                slidesPerGroup: slidesPerViewSelectionMobileVal,
                            {% endif %}
                            centeredSlides: false,
                            spaceBetween: itemDesktopSpaceBetween,
                        },
                        992: {
                            slidesPerView: slidesPerViewSelectionDesktopVal,
                            {% if settings.banner_products_scroll_quantity == "all" %}
                                slidesPerGroup: slidesPerViewSelectionDesktopVal,
                            {% endif %}
                            centeredSlides: false,
                        },
                        1199: {
                            slidesPerView: slidesPerViewSelectionDesktopVal,
                            {% if settings.banner_products_scroll_quantity == "all" %}
                                slidesPerGroup: slidesPerViewSelectionDesktopVal,
                            {% endif %}
                            centeredSlides: false,
                        }
                    }
                });

            {% endif %}

        {% endif %}

        {# /* // Brands slider */ #}

        {% if settings.brands and settings.brands is not empty %}

            {% if settings.brands_autoplay %}
                var autoplayBrandsVal = {delay: 6000,}
            {% else %}
                var autoplayBrandsVal = false;
            {% endif %}

            createSwiper('.js-swiper-brands', {
                lazy: true,
                {% if settings.brands | length > 5 %}
                    loop: true,
                {% endif %}
                watchOverflow: true,
                centerInsufficientSlides: true,
                spaceBetween: 30,
                slidesPerView: 1,
                slidesPerGroup: 1,
                slidesPerGroupAuto: true,
                autoplay: autoplayBrandsVal,
                navigation: {
                    nextEl: '.js-swiper-brands-next',
                    prevEl: '.js-swiper-brands-prev',
                },
                pagination: {
                    el: '.swiper-brands-pagination',
                },
                breakpointsInverse: true,
                breakpoints: {
                    640: {
                        slidesPerView: 5,
                        slidesPerGroup: 5,
                    },
                    500: {
                        sliderPerView: 4,
                        slidesPerGroup: 4,
                    }
                }
            });

        {% endif %}

    {% endif %}

    {% if template == 'home' or (settings.show_testimonials and template == 'product') %}

        {# /* // Testimonials slider */ #}

        {% set testimonials_quantity = settings.testimonials_per_view ? settings.testimonials_per_view : 4 %}

        createSwiper('.js-home-testimonials', {
            lazy: true,
            watchOverflow: true,
            centeredSlides: false,
            centerInsufficientSlides: true,
            spaceBetween: 0,
            loop: false,
            navigation: {
                nextEl: '.js-swiper-testimonials-next',
                prevEl: '.js-swiper-testimonials-prev',
            },
            pagination: {
                el: '.js-testimonials-pagination',
            },
            slidesPerView: 1,
            breakpoints: {
                768: {
                    slidesPerView: 1,
                    centeredSlides: false,
                    navigation: { enabled: false },
                },
                992: {
                    slidesPerView: {{ testimonials_quantity < 3 ? 2 : 3 }},
                    slidesPerGroup: {{ testimonials_quantity < 3 ? 2 : 3 }},
                    centeredSlides: false,
                },
                1199: {
                    slidesPerView: {{ testimonials_quantity }},
                    slidesPerGroup: {{ testimonials_quantity }},
                    centeredSlides: false,
                }
            }
        });

    {% endif %}

    {% if template == 'home' and settings.blog_posts_format_mobile == 'slider' %}

        if (window.innerWidth < 768) {
            createSwiper('.js-swiper-blog-posts', {
                lazy: true,
                watchOverflow: true,
                threshold: 5,
                watchSlideProgress: true,
                watchSlidesVisibility: true,
                slideVisibleClass: 'js-swiper-slide-visible',
                centerInsufficientSlides: true,
                spaceBetween: itemSwiperSpaceBetween,
                slidesPerView: 1.15,
                pagination: {
                    el: '.js-swiper-blog-posts-pagination',
                },
            });
        }

    {% endif %}

    {% if template == 'product' %}


        {# /* // Image zoom on hover */ #}

        {% if settings.product_gallery_zoom == "zoom" %}

            if (window.innerWidth > 768) {
                var productSlideImages = document.querySelectorAll('.js-product-slide-img');
                var maxZoomImageDimension = 3840;

                productSlideImages.forEach(function(zoomTrigger) {
                    var productSlide = zoomTrigger.closest('.js-product-slide');
                    if (productSlide) {
                        var swiperProduct = productSlide.closest('.js-swiper-product');
                        if (swiperProduct) {
                            var sourceWidth = parseFloat(zoomTrigger.getAttribute('width')) || zoomTrigger.naturalWidth;
                            var sourceHeight = parseFloat(zoomTrigger.getAttribute('height')) || zoomTrigger.naturalHeight;
                            var renderedWidth = zoomTrigger.clientWidth;
                            var renderedHeight = zoomTrigger.clientHeight;

                            if (!sourceWidth || !sourceHeight || !renderedWidth || !renderedHeight) {
                                return;
                            }

                            var sourceScale = Math.min(1, maxZoomImageDimension / Math.max(sourceWidth, sourceHeight));
                            var zoomFactor = Math.min(
                                sourceWidth * sourceScale / renderedWidth,
                                sourceHeight * sourceScale / renderedHeight
                            );

                            if (zoomFactor <= 1) {
                                return;
                            }

                            new Drift(zoomTrigger, {
                                paneContainer: swiperProduct,
                                inlinePane: false,
                                zoomFactor: zoomFactor,
                            });
                        }
                    }
                });
            }

        {% endif %}

        {# /* // Fixed add to cart form */ #}
        
        var $fixed_product_form = jQueryNuvem('.js-fixed-product-form');
        var $fixed_product_form_placeholder = jQueryNuvem(".js-fixed-product-form-placeholder");
        var distance = jQueryNuvem(".js-product-detail-bottom").offset().top;
        var name_distance = jQueryNuvem(".js-product-name").offset().top;
        var product_form_height = jQueryNuvem(".js-fixed-product-form").height();
        var footer = jQueryNuvem(".js-footer");
        
        $fixed_product_form_placeholder.height(product_form_height - 5);

        window.addEventListener("scroll", function(event) {
            var scrollPosition = window.pageYOffset;
            if (scrollPosition >= (distance - 100)) {
                $fixed_product_form_placeholder.show();
                $fixed_product_form.addClass("fixed-product-form");
                $fixed_product_form.find(".js-product-variants:not(.product-variants-show)").hide();
                var fixed_product_height = jQueryNuvem(".js-fixed-product-form-placeholder").outerHeight();
                footer.css("paddingBottom", fixed_product_height + "px");
                {% if not product.variations %}
                    $fixed_product_form.find(".js-product-without-variants").hide();
                {% endif %}
            } else {
                $fixed_product_form_placeholder.hide();
                $fixed_product_form.removeClass("fixed-product-form");
                $fixed_product_form.find('.js-product-variants').show();
                {% if not product.variations %}
                    $fixed_product_form.find(".js-product-without-variants").show();
                {% endif %}
                footer.css("paddingBottom", "0");
            }
        });

        jQueryNuvem(document).on("click", ".js-scroll-to-form", function(e) {
            window.scrollTo({
                top: name_distance,
                behavior: 'smooth'
            });
        });

        {# /* // Product Related */ #}

        // Set loop for related products products sliders

        function calculateRelatedLoopVal(sectionSelector) {
            let productsAmount = jQueryNuvem(sectionSelector).attr("data-related-amount");
            let loopVal = false;
            const applyLoop = (window.innerWidth < 768 && productsAmount > slidesPerViewMobileVal) || (window.innerWidth > 768 && productsAmount > slidesPerViewDesktopVal);
            
            if (applyLoop) {
                loopVal = true;
            }
            
            return loopVal;
        }

        function setSlidesPerViewMobile(sectionSelector) {
            let productsAmount = jQueryNuvem(sectionSelector).attr("data-related-amount");
            var slidesPerViewRelatedMobileVal;

            if (productsAmount > 2) {
                slidesPerViewRelatedMobileVal = slidesPerViewMobileVal;
            } else {
                slidesPerViewRelatedMobileVal = 2;
            }

            return slidesPerViewRelatedMobileVal;
        }

        let alternativeLoopVal = calculateRelatedLoopVal(".js-related-products");
        let complementaryLoopVal = calculateRelatedLoopVal(".js-complementary-products");
        let slidesPerViewRelated = setSlidesPerViewMobile(".js-related-products");
        let slidesPerViewComplementary = setSlidesPerViewMobile(".js-complementary-products");

        {# Alternative products #}

        createSwiper('.js-swiper-related', {
            lazy: true,
            loop: alternativeLoopVal,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            spaceBetween: itemSwiperSpaceBetween,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: slidesPerViewRelated,
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            on: {
                afterInit: function () {
                    hideSwiperControls(".js-swiper-related-prev", ".js-swiper-related-next");
                },
            },
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewDesktopVal,
                    slidesPerGroup: slidesPerViewDesktopVal,
                }
            }
        });

        {# Complementary products #}

        createSwiper('.js-swiper-complementary', {
            lazy: true,
            loop: complementaryLoopVal,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            spaceBetween: itemSwiperSpaceBetween,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: slidesPerViewComplementary,
            navigation: {
                nextEl: '.js-swiper-complementary-next',
                prevEl: '.js-swiper-complementary-prev',
            },
            on: {
                afterInit: function () {
                    hideSwiperControls(".js-swiper-complementary-prev", ".js-swiper-complementary-next");
                },
            },
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewDesktopVal,
                    slidesPerGroup: slidesPerViewDesktopVal,
                }
            }
        });

        {# /* // Informatives slider */ #}

        {% set active_banners = (settings.product_informative_banner_01_show ? 1 : 0) + (settings.product_informative_banner_02_show ? 1 : 0) + (settings.product_informative_banner_03_show ? 1 : 0) %}

        {% if active_banners >= 2 %}

            var width = window.innerWidth;
            if (width < 767) {   
                createSwiper('.js-informative-product', {
                    autoplay: true,
                    navigation: {
                        nextEl: '.js-informative-product-next',
                        prevEl: '.js-informative-product-prev',
                    },
                });
            }

        {% endif %}

    {% endif %}
    
	{#/*============================================================================
	  #Social
	==============================================================================*/ #}

    {% if template == 'home' and settings.video_embed %}
        {% set video_url = settings.video_embed %}
        {% if '/watch?v=' in settings.video_embed %}
            {% set video_format = '/watch?v=' %}
        {% elseif '/youtu.be/' in settings.video_embed %}
            {% set video_format = '/youtu.be/' %}
        {% elseif '/shorts/' in settings.video_embed %}
            {% set video_format = '/shorts/' %}
        {% endif %}
        {% set video_id = video_url|split(video_format)|last %}

        {# /* // Youtube video with autoplay */ #}

        function loadVideoFrame() {
            window.youtubeIframeService.executeOnReady(() => { 
                new YT.Player('player', {
                        width: '100%',
                        videoId: '{{video_id}}',
                        playerVars: { 'autoplay': 1, 'playsinline': 1, 'rel': 0, 'loop': 1, 'autopause': 0, 'controls': 0, 'showinfo': 0, 'modestbranding': 1, 'branding': 0, 'fs': 0, 'iv_load_policy': 3 },
                        events: {
                            'onReady': onPlayerReady,
                            'onStateChange':onPlayerStateChange
                        }
                    }
                );
            });
        };

        {% if settings.home_order_position_1 == 'video' and settings.video_type == 'autoplay' %}
            if (window.innerWidth < 768) {
                window.addEventListener("pointerdown", () => {
                    loadVideoFrame();
                }, { once: true });
            } else {
                loadVideoFrame();
            }
        {% else %}
            {% if settings.video_type == 'autoplay' %}
                jQueryNuvem('.js-home-video-container').on('lazyloaded', function(e){
                    loadVideoFrame();
                });
            {% else %}
                jQueryNuvem('.js-play-button').on("click", function(e){
                    e.preventDefault();
                    jQueryNuvem(this).hide();
                    jQueryNuvem(".js-home-video-image").hide();
                    loadVideoFrame();
                });
            {% endif %}
        {% endif %}
        

        function onPlayerReady(event) {
            {% if settings.video_type == 'autoplay' %}
                event.target.mute();
            {% endif %}
            event.target.playVideo();
        }

        function onPlayerStateChange(event) {
            {% if settings.home_order_position_1 == 'video' %}
                if (event.data == YT.PlayerState.PLAYING) {
                    jQueryNuvem(".js-home-video-image").addClass("fade-in");
                }
            {% endif %}
            if (event.data == YT.PlayerState.ENDED) {
                event.target.seekTo(0);
                event.target.playVideo();
            }
        }

    {% endif %}

    {% if template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
        {# /* // Youtube or Vimeo video for home or each product */ #}
        LS.loadVideo('{{ video_url }}');
    {% endif %}

    {% set native_videos_enabled = false %}
    {% if template == 'product' and (product.hasNativeVideos or product.media|filter(m => m.isVideo)|length > 0) %}
        {% set native_videos_enabled = true %}
    {% endif %}
    {% if template == 'home' and sections.featured.products %}
        {% for product in sections.featured.products %}
            {% if product.hasNativeVideos or product.media|filter(m => m.isVideo)|length > 0 %}
                {% set native_videos_enabled = true %}
            {% endif %}
        {% endfor %}
    {% endif %}

    {% if template == 'product' or (template == 'home' and sections.featured.products) %}
        {% if native_videos_enabled %}
            var stream_videos = [];
            function initAllVideos(){
                jQueryNuvem(".js-external-video-iframe").each(function($el){
                    const player = Stream(document.getElementById($el.id));
                    stream_videos.push(player);
                });
            }
            initAllVideos();
            function pauseAllVideos(){
                stream_videos.forEach(function(player){
                    player.pause();
                });
            }
            jQueryNuvem(".js-play-native-button").on("click", function($el){
                pauseAllVideos();
                const link = jQueryNuvem(this);
                const id = jQueryNuvem(this).data("video_uid");
                const iframe = jQueryNuvem("#video-" + id);
                const image = jQueryNuvem("img[data-video_uid='" + id + "']");
                const parent = jQueryNuvem(this).parent(".embed-responsive-16by9");
                const container = jQueryNuvem("div[data-video_uid='" + id + "']");
                iframe.attr("src", iframe.data("src"));
                container.show();
                image.hide();
                link.hide().removeClass("d-md-block");
                parent.removeClass("embed-responsive-16by9");
                let allowAttr = iframe.attr("allow");

                if (allowAttr) {
                    allowAttr = allowAttr
                        .split(";")
                        .map(item => item.trim())
                        .filter(item => item && item !== "autoplay")
                        .join("; ");

                    iframe.attr("allow", allowAttr + ";");
                }
            });
        {% endif %}
    {% endif %}

	{#/*============================================================================
	  #Product grid
	==============================================================================*/ #}

    var $category_controls = jQueryNuvem(".js-category-controls");
    var mobile_nav_height = jQueryNuvem(".js-head-main").innerHeight();
    var nav_height = jQueryNuvem(".js-head-main").innerHeight();

	{% if template == 'category' or (template == 'search' and search_filter) %}

        {# /* // Fixed category controls */ #}

            if (window.innerWidth < 768) {
                var lastScroll = 0;
                $category_controls.css("top" , nav_height.toString() + 'px');

                {# Detect if category controls are sticky and add css #}

                var observer = new IntersectionObserver(function(entries) {
                    if(entries[0].intersectionRatio === 0)
                        $category_controls.addClass("is-sticky");
                    else if(entries[0].intersectionRatio === 1)
                        $category_controls.removeClass("is-sticky");
                    }, { threshold: [0,1]
                });
                var categoryControlsPrev = document.querySelector(".js-category-controls-prev");
                if (categoryControlsPrev) {
                    observer.observe(categoryControlsPrev);
                }

                offsetCategories = function() {
                    var scrollPos = window.pageYOffset;
                    var $sticky_category_controls = jQueryNuvem(".js-category-controls");

                    var categoriesOffset = jQueryNuvem(".js-head-fixed").outerHeight();

                    if(jQueryNuvem(".js-head-main").hasClass("compress")){
                        var categoriesOffset = categoriesOffset - topbarHeight - 1;
                    }

                    if (scrollPos > lastScroll && scrollPos > categoriesOffset) {
                        $sticky_category_controls.css('top', (categoriesOffset - 1).toString() + 'px' );
                    } else {
                        $sticky_category_controls.css('top', '0px' );
                    }
                    lastScroll = scrollPos;                    
                };

                offsetCategories();

                document.addEventListener("scroll", function(){
                    offsetCategories();
                });

            }

        {# /* // Filters */ #}

        {% if has_applied_filters %}
            jQueryNuvem('.js-filter-container').each(function(el) {
                const filterActive = jQueryNuvem(el).find(".js-filter-checkbox [type=checkbox]:checked");
                filterActive.closest(".js-filter-container").find(".js-filters-badge").text(filterActive.length).show();
            });
            const applied_filters = jQueryNuvem("#nav-filters .js-remove-filter-chip").length;
            jQueryNuvem(".js-filters-total-badge").text(applied_filters);
        {% endif %}

		{# /* // Sort by */ #}

        function applySortBy(element, isFromSelect) {
            var params = LS.urlParams;

            if(isFromSelect){
                params['sort_by'] = jQueryNuvem(element).val();
            }else{
                params['sort_by'] = jQueryNuvem(element).attr('data-sort-value');
            }

            var sort_params_array = [];
            for (var key in params) {
                if (!['results_only', 'page'].includes(key)) {
                    sort_params_array.push(key + '=' + params[key]);
                }
            }
            var sort_params = sort_params_array.join('&');
            window.location = window.location.pathname + '?' + sort_params;
        }

        jQueryNuvem(document).on("click", ".js-apply-sort", function(e) {
            e.preventDefault();
            jQueryNuvem(".js-apply-sort").removeClass("selected");

            var thisElement = jQueryNuvem(this);

            thisElement.addClass("selected");
            applySortBy(thisElement, false);
            if (window.innerWidth < 768) {
                jQueryNuvem(".js-sorting-overlay, .js-filtering-spinner").show();
            }
        });

        jQueryNuvem('.js-sort-by').on("change", function (e) {

            var thisElement = jQueryNuvem(this);
            applySortBy(thisElement, true);

        });

        {% if settings.category_content %}
            {# Fetch category SEO content from institutional page (/cat-{slug}) #}
            var seoContentArea = document.getElementById('seo-content-area');
            if (seoContentArea) {
                var categorySlug = "{{ category.url | trim('/') | split('/') | last }}";
                var categoryContentUrl = '/cat-' + categorySlug;
                fetch(categoryContentUrl)
                    .then(function(response) {
                        return response.ok ? response.text() : '';
                    })
                    .then(function(html) {
                        if (!html) {
                            return;
                        }
                        var parser = new DOMParser();
                        var doc = parser.parseFromString(html, 'text/html');
                        var content = doc.querySelector('.user-content');
                        if (content) {
                            seoContentArea.innerHTML = content.innerHTML;
                        }
                    })
                    .catch(function() {
                        {# Keep silent: feature is optional and should not break category page #}
                    });
            }
        {% endif %}

    {% endif %}

    {% if (template == 'category' or template == 'search') %}

        !function() {

        	{# /* // Infinite scroll */ #}

            {% if (pages.current == 1 and not pages.is_last) and settings.pagination == 'infinite' %}

                {% if settings.grid_columns_desktop == '5' %}
                    const products_per_page_value = 15;
                {% else %}
                    const products_per_page_value = 12;
                {% endif %}
                
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: products_per_page_value,
                    afterLoaded: function(){
                        jQueryNuvem('.js-item-product').addClass('is-inViewport');
                    },
                });
            {% endif %}
        }();

        {% if (template == 'category' or template == 'search') and settings.pagination == 'classic' %}

            {# /* // Mobile pagination */ #}

            jQueryNuvem(document).on("focusout", ".js-mobile-paginator-input", function (e) {
                e.preventDefault();
                LS.paginateMobile();
            });

            jQueryNuvem(document).on("keypress", ".js-mobile-paginator-input", function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    LS.paginateMobile();
                }
            });

        {% endif %}

	{% endif %}

    {# /* // Variants without stock */ #}

    {% set is_button_variant = settings.bullet_variants or settings.image_color_variants %}

    {% if is_button_variant %}
        const noStockVariants = (container = null) => {

            {# Configuration for variant elements #}
            const config = {
                variantsGroup: ".js-product-variants-group",
                variantButton: ".js-insta-variant",
                noStockClass: "btn-variant-no-stock",
                dataVariationId: "data-variation-id",
                dataOption: "data-option"
            };

            {# Product container wrapper #}
            const wrapper = container ? container : jQueryNuvem('#single-product');
            if (!wrapper) return;

            {# Fetch the variants data from the container #}
            const dataVariants = wrapper.data('variants');
            const variantsLength = wrapper.find(config.variantsGroup).length;

            {# Get selected options from product variations #}
            const getOptions = (productVariationId, variantOption) => {
                if (productVariationId === 2) {
                    return {
                        option0: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="0"] select`).val()),
                        option1: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="1"] select`).val()),
                        option2: String(jQueryNuvem(variantOption).attr('data-option')),
                    };
                } else if (productVariationId === 1) {
                    return {
                        option0: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="0"] select`).val()),
                        option1: String(jQueryNuvem(variantOption).attr('data-option')),
                    };
                } else {
                    return {
                        option0: String(jQueryNuvem(variantOption).attr('data-option')),
                    };
                }
            };

            {# Filter available variants based on selected options #}
            const filterVariants = (options) => {
                return dataVariants.filter(variant => {
                    return Object.keys(options).every(optionKey => variant[optionKey] === options[optionKey]) && variant.available;
                });
            };

            {# Update stock status for variant buttons #}
            const updateStockStatus = (productVariationId) => {
                const variationGroup = wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="${productVariationId}"]`);
                variationGroup.find(`${config.variantButton}.${config.noStockClass}`).removeClass(config.noStockClass);

                variationGroup.find(config.variantButton).each((variantOption, item) => {
                    const options = getOptions(productVariationId, variantOption);
                    const itemsAvailable = filterVariants(options);
                    const button = wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="${productVariationId}"] ${config.variantButton}[${config.dataOption}="${options[`option${productVariationId}`].replace(/"/g, '\\"')}"]`);
                    
                    if (!itemsAvailable.length) {
                        button.addClass(config.noStockClass);
                    }
                });
            };

            {# Iterate through all variant and update stock status #}
            for (let productVariationId = variantsLength - 1; productVariationId >= 0; productVariationId--) {
                updateStockStatus(productVariationId);
            }
        };

        noStockVariants();

    {% endif %}

    {% if settings.quick_shop %}

        {# /* // Quickshop */ #}

        jQueryNuvem(document).on("click", ".js-quickshop-modal-open", function (e) {
            e.preventDefault();
            var $this = jQueryNuvem(this);
            if($this.hasClass("js-quickshop-slide")){
                jQueryNuvem("#quickshop-modal .js-item-product").addClass("js-swiper-slide-visible js-item-slide");
            }

             LS.fillQuickshop($this);

            {# Trigger initial variant state so CTA and nostock indicators are correct on open #}
            var $modalFirstSelect = jQueryNuvem('#quickshop-modal .js-quickshop-container select[name^=variation]').first();
            if ($modalFirstSelect.length) {
                $modalFirstSelect.trigger('change');
            }

            if (window.innerWidth < 768) {
                {# Image dimensions #}

                var product_image_dimension = jQueryNuvem(this).closest('.js-item-product').find('.js-item-image-padding').attr("style");
                jQueryNuvem("#quickshop-modal .js-quickshop-image-padding").attr("style", product_image_dimension);

                {# Add bottom space to ensure CTA visibility when not bottom sheet #}

                var quickshop_height = jQueryNuvem("#quickshop-modal").height();
                var quickshop_header_height = jQueryNuvem("#quickshop-modal .js-quickshop-header").height();

                if(window.innerHeight < (quickshop_height + 1)){
                    jQueryNuvem("#quickshop-form").css("marginBottom" , quickshop_header_height + "px");
                }
            }

        });

    {% endif %}

    {% if settings.bullet_variants or settings.product_color_variants or settings.image_color_variants %}
        changeVariantButton = function(selector, parentSelector) {
            selector.siblings().removeClass("selected");
            selector.addClass("selected");
            var option_id = selector.attr('data-option');
            var parent = selector.closest(parentSelector);
            var selected_option = parent.find('.js-variation-option option').filter(function (el) {
                return el.value == option_id;
            });
            selected_option.prop('selected', true).trigger('change');
            parent.find('.js-insta-variation-label').html(option_id);
        };


        {% if settings.bullet_variants or settings.image_color_variants %}
            {# /* // Color and size variations */ #}

            jQueryNuvem(document).on("click", ".js-insta-variant", function (e) {
                e.preventDefault();
                $this = jQueryNuvem(this);
                changeVariantButton($this, '.js-product-variants-group');
            });

        {% endif %}


        {% if settings.product_color_variants %}

            {# Product color variations #}
            
            jQueryNuvem(document).on("click", ".js-color-variant", function(e) {
                e.preventDefault();
                $this = jQueryNuvem(this);
                changeVariantButton($this, '.js-item-product');
            });
            
        {% endif %}

    {% endif %}

    {% if settings.quick_shop or settings.product_color_variants %}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}
            var current_image = jQueryNuvem('.js-item-product[data-product-id="'+variant.product_id+'"] .js-item-image');
            current_image.attr('srcset', variant.image_url);

            {% if settings.product_hover %}
                {# Remove secondary feature on image updated from changeVariant #}
                var product_container = current_image.closest(".js-item-product");
                product_container.find(".js-product-item-private-with-secondary-images").addClass("product-item-secondary-images-disabled");
            {% endif %}
        });

    {% endif %}
    

    {#/*============================================================================
	  #Product detail functions
	==============================================================================*/ #}

	{# /* // Installments */ #}

	{# Installments without interest #}

	function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
	        if (installment_data.without_interests) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_without_interests;
	}

	{# Installments with interest #}

	function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
	        if (installment_data.without_interests == false) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_with_interests;
	}

	{# Updates installments on payment popup for native integrations #}

	function refreshInstallmentv2(price){
        jQueryNuvem(".js-modal-installment-price" ).each(function( el ) {
	        const installment = Number(jQueryNuvem(el).data('installment'));
	        jQueryNuvem(el).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
	    });
	}

	{# /* // Change variant */ #}

	{# Updates price, installments, labels and CTA on variant change #}

	function changeVariant(variant) {
        jQueryNuvem(".js-product-detail .js-shipping-calculator-response").hide();
        jQueryNuvem("#shipping-variant-id").val(variant.id);

	    var parent = jQueryNuvem("body");
	    if (variant.element) {
            parent = jQueryNuvem(variant.element);
            if(parent.hasClass("js-quickshop-container")){
                var quick_id = parent.attr("data-quickshop-id");
                if(parent.hasClass("js-quickshop-modal")){
                    var parent = jQueryNuvem('#quickshop-modal .js-quickshop-container');
                } else {
                    var parent = jQueryNuvem('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                }
            }
	    }

        {% if is_button_variant %}
            {# Updates variants without stock #}
            if(parent.hasClass("js-quickshop-container")){
                var itemContainer = parent.closest('.js-item-product');
                if(itemContainer.hasClass("js-item-slide")){
                    var parent = jQueryNuvem('#quickshop-modal .js-quickshop-container');
                }
                noStockVariants(parent);
            } else {
                noStockVariants();
            }
        {% endif %}

	    var sku = parent.find('.js-product-sku');
	    if(sku.length) {
	        sku.text(variant.sku).show();
	    }

	    {% if settings.product_stock %}
	        var stock = parent.find('.js-product-stock');
	        stock.text(variant.stock).show();
	    {% endif %}

        {# Updates installments on list item and inside payment popup for Payments Apps #}
        
	    var installment_helper = function($element, amount, price){
	        $element.find('.js-installment-amount').text(amount);
	        $element.find('.js-installment-price').attr("data-value", price);
	        $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
	            $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        } else {
	            $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        }
	    };

        var $payments_module = jQueryNuvem(variant.element + ' .js-product-payments-container');

	    if (variant.installments_data) {
	        var variant_installments = JSON.parse(variant.installments_data);
	        var max_installments_without_interests = [0,0];
	        var max_installments_with_interests = [0,0];

	        {# Hide all installments rows on payments modal #}
	        jQueryNuvem('.js-payment-provider-installments-row').hide();

	        for (let payment_method in variant_installments) {

	            {# Identifies the minimum installment value #}
	            var paymentMethodId = '#installment_' + payment_method.replace(" ", "_") + '_1';
	            var minimumInstallmentValue = jQueryNuvem(paymentMethodId).closest('.js-info-payment-method').attr("data-minimum-installment-value");

                let installments = variant_installments[payment_method];
	            for (let number_of_installment in installments) {
                    let installment_data = installments[number_of_installment];
	                max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
	                max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
	                var installment_container_selector = '#installment_' + payment_method.replace(" ", "_") + '_' + number_of_installment;

	                {# Shows installments rows on payments modal according to the minimum value #}
	                if(minimumInstallmentValue <= installment_data.installment_value) {
	                    jQueryNuvem(installment_container_selector).show();
	                }

	                if(!parent.hasClass("js-quickshop-container")){
	                    installment_helper(jQueryNuvem(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
	                }
	            }
	        }
	        var $installments_container = jQueryNuvem(variant.element + ' .js-max-installments-container .js-max-installments');
	        var $installments_modal_link = jQueryNuvem(variant.element + ' #btn-installments');
	        var $installmens_card_icon = jQueryNuvem(variant.element + ' .js-installments-credit-card-icon');

	        {% if product.has_direct_payment_only %}
	        var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 0 ) {
	        {%  else %}
	        var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 1 ) {
	        {% endif %}
	            $installments_container.hide();
	            $installments_modal_link.hide();
	            $payments_module.hide();
	            $installmens_card_icon.hide();
	        } else {
	            $installments_container.show();
	            $installments_modal_link.show();
	            $payments_module.show();
	            $installmens_card_icon.show();
	            installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
	        }
	    }

        if (variant.contact) {
            $payments_module.hide();
        }

	    if(!parent.hasClass("js-quickshop-container")){
            jQueryNuvem('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
		}

	    if (variant.price_short){
	        parent.find('.js-price-display').text(variant.price_short).show();
	        parent.find('.js-price-display').attr("content", variant.price_number).data('productPrice', variant.price_number_raw);
            } else {
	        parent.find('.js-price-display').hide();
	    }

	    if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
	        parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();
	    } else {
	        parent.find('.js-compare-price-display').hide();
	    }

        const buttonStates = {
            nostock: {
                text: '{{ "Sin stock" | translate }}',
                buttonClass: 'nostock',
                isDisabled: true,
                showShipping: false
            },
            contact: {
                text: '{{ "Consultar precio" | translate }}',
                buttonClass: 'contact',
                isDisabled: false,
                showShipping: false
            },
            cart: {
                text: '{{ product_button_text }}',
                quickshopText: '{{ add_button_text }}',
                buttonClass: 'cart',
                isDisabled: false,
                showShipping: true
            }
        };

        const updateButtonState = (parent, state) => {
            const config = buttonStates[state];
            const elements = {
                button: parent.find('.js-addtocart'),
                quickshopText: parent.find('.js-open-quickshop-wording'),
                quickshopIcon: parent.find('.js-open-quickshop-icon'),
                shipping: parent.find("#product-shipping-container"),
                fixedButton: parent.find('.js-scroll-to-form')
            };

            elements.button
                .val(config.text)
                .removeClass('cart contact nostock')
                .addClass(config.buttonClass)
                .prop('disabled', config.isDisabled);

            elements.quickshopText.text(config.quickshopText || config.text);
            elements.quickshopIcon.toggleClass('d-md-inline', state === 'cart')
                .toggleClass('d-none', state !== 'cart');

            elements.fixedButton
                .text(config.text)
                .removeClass('cart contact nostock')
                .addClass(config.buttonClass)
                .prop('disabled', config.isDisabled);

            config.showShipping ? elements.shipping.show() : elements.shipping.hide();
        };

        {% if not store.is_catalog %}
            const state = !variant.available ? 'nostock' 
                        : variant.contact ? 'contact' 
                        : 'cart';
            updateButtonState(parent, state);
        {% endif %}

        {% if template == 'product' %}
            const base_price = Number(jQueryNuvem("#price_display").attr("content"));
            refreshInstallmentv2(base_price);
        {% endif %}

        {% if settings.last_product %}
            if(variant.stock == 1) {
                parent.find('.js-last-product').show();
            } else {
                parent.find('.js-last-product').hide();
            }
        {% endif %}

        {% if template == 'product' and store.whatsapp %}
            var productUrlWithSelectedVariant = "{{ product.url | escape('js') }}";
            productUrlWithSelectedVariant = productUrlWithSelectedVariant.replace(/([?&])variant=[^&]*(&?)/, function(match, separator, suffix) {
                return suffix ? separator : '';
            }).replace(/[?&]$/, '');
            productUrlWithSelectedVariant += (productUrlWithSelectedVariant.indexOf('?') === -1 ? '?' : '&') + 'variant=' + variant.id;

            var whatsappProductText = "{{ ("¡Hola! Me gustaría más información sobre" | translate ~ ": " ~ product.name ~ " - ") | escape('js') }}" + productUrlWithSelectedVariant;

            parent.find('.js-product-whatsapp-link').attr('href', "{{ store.whatsapp | escape('js') }}?text=" + encodeURIComponent(whatsappProductText));
        {% endif %}


        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        zipcode_on_changevariant = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
        jQueryNuvem("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true);

        {% endif %}


        {# Unit price when there is a quantity variation #}

        {% if template == "product" and settings.product_unity_price %}
            {% if product.variations %}
                {% for variation in product.variations %}
                    {% if variation.name|lower in quantity_variation %}
                        {% if settings.bullet_variants %}
                            var amount = jQueryNuvem('.js-product-quantity .js-insta-variant.selected').attr('data-option');
                        {% else %}
                            var amount = jQueryNuvem('.js-product-quantity .js-variation-option').val();
                        {% endif %}
                        
                        var numericAmount = parseFloat(amount.replace(/[^0-9.]/g, ''));
                        var price = variant.price_number;

                        let unit = (price / numericAmount).toLocaleString('de-DE', { 
                            maximumFractionDigits: 2, 
                            minimumFractionDigits: 2 
                        });

                        unit = `${LS.currency.display_short}${unit}`;

                        jQueryNuvem('.js-price-unit').html(unit);
                    {% endif %}
                {% endfor %}
            {% endif %}
        {% endif %}

        LS.subscriptionChangeVariant(variant);

	}

	{# /* // Trigger change variant */ #}

    jQueryNuvem(document).on("change", ".js-variation-option", function(e) {
        var $parent = jQueryNuvem(this).closest(".js-product-variants");
        var $variants_group = jQueryNuvem(this).closest(".js-product-variants-group");
        var $quickshop_parent_wrapper = jQueryNuvem(this).closest(".js-quickshop-container");

        {# If quickshop is used from modal, use quickshop-id from the item that opened it #}

        var quick_id = $quickshop_parent_wrapper.attr("data-quickshop-id");

        if($parent.hasClass("js-product-quickshop-variants")){

            var $quickshop_parent = jQueryNuvem(this).closest(".js-item-product");

            {# Pick the visible quickshop container: prefer the swiper's current visible slide
               when the quickshop lives inside a slider, otherwise match by quickshop-id #}

             if($quickshop_parent_wrapper.hasClass("js-quickshop-modal")){
                jQueryNuvem('#quickshop-modal .js-quickshop-container .js-product-variants-group').each(function(index, variantGroup) {
                    var $group = jQueryNuvem(variantGroup);
                    var $selectedBtn = $group.find('.js-insta-variant.selected');
                    if ($selectedBtn.length) {
                        $group.find('.js-variation-option').val($selectedBtn.attr('data-option'));
                    }
                });
                var $quickshop_variant_selector = '#quickshop-modal .js-quickshop-container';
            } else if($quickshop_parent.hasClass("js-item-slide")){
                var $quickshop_variant_selector = '.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            } else {
                var $quickshop_variant_selector = '.js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }

            LS.changeVariant(changeVariant, $quickshop_variant_selector);

            {% if settings.product_color_variants or settings.bullet_variants or settings.image_color_variants %}
                {# Match selected color variant with selected quickshop variant #}

                var selected_option_id = jQueryNuvem(this).val();
                var $color_parent_to_update = jQueryNuvem('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                $color_parent_to_update.find('.js-color-variant[data-option="'+selected_option_id+'"], .js-insta-variant[data-option="'+selected_option_id+'"]').addClass("selected").siblings().removeClass("selected");
            {% endif %}

        } else {
            LS.changeVariant(changeVariant, '#single-product');
        }

        {# Offer and discount labels update #}

        var $this_product_container = jQueryNuvem(this).closest(".js-product-container");

        if($this_product_container.hasClass("js-quickshop-container")){
            if($this_product_container.hasClass("js-quickshop-modal")){
                var $this_product_container = jQueryNuvem('#quickshop-modal .js-product-container');
            } else {
                var this_quickshop_id = $this_product_container.attr("data-quickshop-id");
                var $this_product_container = jQueryNuvem('.js-product-container[data-quickshop-id="'+this_quickshop_id+'"]');
            }
        }
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart = $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

        if ($this_compare_price.css("display") == "none" || !percentageDifference) {
            $this_product_container.find(".js-offer-label").hide();
        }
        if ($this_add_to_cart.hasClass("nostock")) {
            var $stockLabel = $this_product_container.find(".js-stock-label");
            if (!$stockLabel.text().trim()) {
                $stockLabel.text($stockLabel.data('label'));
            }
            $stockLabel.show();
            $this_product_container.find(".js-offer-label").hide();
            $this_product_container.find(".js-shipping-label").hide();
        }
        else {
            $this_product_container.find(".js-stock-label").hide();
            $this_product_container.find(".js-shipping-label").show();
	    }
	    if ($this_price.css('display') == 'none'){
	        $installment_container.hide();
	        $installment_text.hide();
	    }else{
	        $installment_text.show();
	    }

        {% if settings.item_unity_price %}
            if ($this_product_container.find('.js-price-unit').length > 0) {
                var $quantityContainer = jQueryNuvem(this).closest('.js-product-quantity');

                if ($quantityContainer.length > 0) {
                    var amount;
                    {% if settings.bullet_variants %}
                        amount = $this_product_container.find('.js-product-quantity .js-insta-variant.selected').attr('data-option');
                    {% else %}
                        amount = $quantityContainer.find('.js-variation-option').val();
                    {% endif %}

                    var numericAmount = parseFloat(amount.replace(/[^0-9.]/g, ''));
                    var price = $this_product_container.find('.js-price-display').attr('content');

                    let unit = (price / numericAmount).toLocaleString('de-DE', { 
                        maximumFractionDigits: 2, 
                        minimumFractionDigits: 2 
                    });

                    unit = `${LS.currency.display_short}${unit}`;

                    $this_product_container.find('.js-price-unit').html(unit);
                }
            }

        {% endif %}

	});

	{# /* // Submit to contact */ #}

	{# Submit to contact form when product has no price #}

    jQueryNuvem(".js-product-form").on("submit", function (e) {
	    var button = jQueryNuvem(e.currentTarget).find('[type="submit"]');
	    button.attr('disabled', 'disabled');
	    if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
	        e.preventDefault();
	        var product_id = jQueryNuvem(e.currentTarget).find("input[name='add_to_cart']").val();
	        window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
	    } else if (button.hasClass('cart')) {
	        button.val('{{ "Agregando..." | translate }}');
	    }
	});

	{% if template == 'product' or (template == 'home' and sections.featured.products) %}

        var has_multiple_slides = false;

        {% if template == 'product' and (product.media_count > 1 or video_url) %}
            var has_multiple_slides = true;
        {% else %}
            var product_images_amount = jQueryNuvem(".js-swiper-product").attr("data-product-images-amount");
            const featured_product_images_amount = document.querySelectorAll('#single-product .js-swiper-product .swiper-slide').length;
            if(product_images_amount > 1 || featured_product_images_amount > 1) {
                var has_multiple_slides = true;
            }
        {% endif %}

	    {# /* // Product slider */ #}

        {% if template == 'product' %}

            {% block product_fancybox %}
                document.querySelectorAll('.js-product-colors').forEach(function(el) {
                    el.addEventListener('click', function() {
                        const fancyBoxValue = el.querySelector('a').getAttribute('data-fancybox')

                        Fancybox.bind(`[data-fancybox="${fancyBoxValue}"]`, {
                            groupAll: true,
                            Toolbar: {
                                items: {
                                    close: {
                                        html: '<svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#times"/></svg>',
                                    },
                                    counter: {
                                        class: 'pt-2 mt-1',
                                        type: 'div',
                                        html: '<span data-fancybox-index=""></span>&nbsp;/&nbsp;<span data-fancybox-count=""></span>',
                                        position: 'center',
                                    },
                                },
                            },
                            Carousel: {
                                Navigation: {
                                    classNames: {
                                        button: 'btn',
                                        next: 'swiper-button-next',
                                        prev: 'swiper-button-prev',
                                    },
                                    prevTpl: '<svg class="icon-inline icon-lg svg-icon-invert icon-flip-horizontal"><use xlink:href="#chevron"/></svg>',
                                    nextTpl: '<svg class="icon-inline icon-lg svg-icon-invert"><use xlink:href="#chevron"/></svg>',
                                },
                            },
                            Thumbs: { autoStart: false },
                            on: {
                                shouldClose: (fancybox, slide) => {
                                    {# Update position of the slider #}
                                    productSwiper.slideTo( fancybox.getSlide().index, 0 );
                                },
                                {% if native_videos_enabled %}
                                "Carousel.change": (fancybox) => {
                                    pauseAllVideos();
                                },
                                {% endif %}
                            },
                        });
                    });
                });
            {% endblock %}
        {% endif %}

        var directionVal = 'vertical';
        var slidesPerViewVal = 'auto'

        {% if template == 'product' %}
            if (window.innerWidth < 767) {
                var directionVal = 'horizontal';
                var slidesPerViewVal = 3.5;
            }
        {% endif %}

        var swiperProductThumbs = null;
        createSwiper('.js-swiper-product-thumbs', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            direction: directionVal,
            navigation: {
                nextEl: '.js-swiper-product-thumbs-next',
                prevEl: '.js-swiper-product-thumbs-prev',
            },
            slidesPerView: 'auto',
        },
            function(swiperInstance) {
                swiperProductThumbs = swiperInstance;
            }
        );

        var productSwiper = null;
        function productSliderNav(){

            var width = window.innerWidth;

            createSwiper(
                '.js-swiper-product', {
                    lazy: true,
                    threshold: 5,
                    centerInsufficientSlides: true,
                    watchOverflow: true,
                    {% if settings.product_gallery_layout == "next" %}
                        spaceBetween: 15,
                        slidesPerView: 1.2,
                    {% else %}
                        slidesPerView: 1,
                    {% endif %}
                    pagination: {
                        el: '.js-swiper-product-pagination',
                    },
                    navigation: {
                        nextEl: '.js-swiper-product-next',
                        prevEl: '.js-swiper-product-prev',
                    },
                    breakpoints: {
                        768: {
                            spaceBetween: 0,
                            slidesPerView: 'auto',
                        }
                    },                    
                    on: {
                        init: function () {
                            {% if (product.video_url or native_videos_enabled) and template == 'product' %}
                                if (window.innerWidth < 768) {
                                    productSwiperHeight = jQueryNuvem(".js-swiper-product").height();
                                    jQueryNuvem(".js-product-video-slide").height(productSwiperHeight);
                                }
                            {% endif %}
                        },
                        {% if (product.video_url or native_videos_enabled) and template == 'product' %}
                            slideChangeTransitionEnd: function () {
                                if(jQueryNuvem(".js-product-video-slide").hasClass("swiper-slide-active")){
                                    jQueryNuvem(".js-labels-group").fadeOut(100);
                                }else{
                                    jQueryNuvem(".js-labels-group").fadeIn(100);
                                }
                                jQueryNuvem('.js-video').show();
                                jQueryNuvem('.js-video-iframe').hide().find("iframe").remove();
                            },
                        {% endif %}
                        {% if native_videos_enabled %}
                            slideChange: function () {
                                pauseAllVideos();
                            },
                        {% endif %}
                    },
                },
                function(swiperInstance) {
                    productSwiper = swiperInstance;
                }
            );

            {% if template == 'product' and settings.product_gallery_zoom == "modal" %}
                {{ block ('product_fancybox') }}
            {% endif %}

            if(has_multiple_slides){
                LS.registerOnChangeVariant(function(variant){
                    var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    
                    {# Skip when the changed variant doesn't belong to this product slider (e.g. quickshop on the grid) #}
                    if (!liImage.length) return;
                    var selectedPosition = liImage.data('imagePosition');
                    var slideToGo = parseInt(selectedPosition);
                    if (isNaN(slideToGo)) return;
                    productSwiper.slideTo(slideToGo);
                    jQueryNuvem(".js-product-slide-img").removeClass("js-active-variant");
                    liImage.find(".js-product-slide-img").addClass("js-active-variant");
                });

                jQueryNuvem(".js-product-thumb").on("click", function(e){
                    e.preventDefault();
                    jQueryNuvem(".js-product-thumb").removeClass("selected");
                    jQueryNuvem(e.currentTarget).addClass("selected");
                    var thumbLoop = jQueryNuvem(e.currentTarget).data("thumbLoop");
                    var slideToGo = parseInt(thumbLoop);
                    productSwiper.slideTo(slideToGo);
                    if(jQueryNuvem(e.currentTarget).hasClass("js-product-thumb-modal")){
                        var video_id = jQueryNuvem(e.currentTarget).data("video_id");
                            if(video_id){
                                jQueryNuvem('#trigger-video-modal-' + video_id).trigger('click');
                                return;
                            }
                        jQueryNuvem('.js-swiper-product').find("[data-image-position='"+slideToGo+"'] .js-product-slide-link").trigger('click');
                    }
                    
                });
                function productVariant() {
                    const productContainer = document.querySelector('#single-product');
                    const colorsContainerEl = productContainer.querySelector('.js-color-variants-container');
                    if (!colorsContainerEl) return;
                    if (!productContainer.querySelector('.js-product-colors')) return;

                    function normalizeKey(s) {
                        return (s || '')
                        .toLowerCase()
                        .replace(' ', '')
                        .trim()
                        .replace(/[ \-_]+/g, '');
                    }

                    const reIndexColors = function() {
                        const thumbEls = productContainer.querySelectorAll('.js-product-thumb-colors:not(.d-none)');
                        const productEls = productContainer.querySelectorAll('.js-product-colors:not(.d-none)');
                        const nativeVideoThumbEls = productContainer.querySelectorAll('.js-product-native-video-thumb');
                        const nativeVideoEls = productContainer.querySelectorAll('.js-product-native-video-slide');

                        thumbEls.forEach((el, index) => {
                            el.querySelector('a')?.setAttribute('data-thumb-loop', index);
                        });
                        productEls.forEach((el, index) => {
                            el.setAttribute('data-image-position', index);
                        });
                        nativeVideoThumbEls.forEach((el, index) => {
                            el.setAttribute('data-thumb-loop', productEls.length + index);
                        });
                        nativeVideoEls.forEach((el, index) => {
                            el.setAttribute('data-image-position', productEls.length + index);
                        });

                        if (swiperProductThumbs && productSwiper) {
                            swiperProductThumbs.update();
                            productSwiper.update();
                        }
                    };

                    const addDisplayNone = el => el.classList.add('d-none');

                    const colorsEls = colorsContainerEl.querySelectorAll('.js-color-variants-container a[data-option]');
                    if (colorsEls) {
                        colorsEls.forEach(colorEl => {
                            if (colorEl.classList.contains('selected')) {
                                const color = colorEl.getAttribute('data-option');
                                const colorNorm = normalizeKey(color);

                                const allThumbs = productContainer.querySelectorAll('.js-product-thumb-colors');
                                const allColors = productContainer.querySelectorAll('.js-product-colors');
                                allThumbs.forEach(addDisplayNone);
                                allColors.forEach(addDisplayNone);

                                productContainer.querySelectorAll('.js-product-thumb-colors').forEach(el => {
                                    if (normalizeKey(el.getAttribute('data-option')) === colorNorm) el.classList.remove('d-none');
                                });
                                productContainer.querySelectorAll('.js-product-colors').forEach(el => {
                                    if (normalizeKey(el.getAttribute('data-option')) === colorNorm) el.classList.remove('d-none');
                                });

                                reIndexColors();
                            }
                        });

                        colorsEls.forEach(colorEl => {
                            colorEl.addEventListener('click', function() {
                                const color = this.getAttribute('data-option');
                                const colorNorm = normalizeKey(color);

                                const allThumbs = productContainer.querySelectorAll('.js-product-thumb-colors');
                                const allColors = productContainer.querySelectorAll('.js-product-colors');
                                allThumbs.forEach(addDisplayNone);
                                allColors.forEach(addDisplayNone);

                                productContainer.querySelectorAll('.js-product-thumb-colors').forEach(el => {
                                if (el.getAttribute('data-option') === colorNorm) el.classList.remove('d-none');
                                });
                                productContainer.querySelectorAll('.js-product-colors').forEach(el => {
                                if (el.getAttribute('data-option') === colorNorm) el.classList.remove('d-none');
                                });

                                reIndexColors();
                            });
                        });
                    }

                    const colorsSelectEl = productContainer.querySelector('.js-color-variants-container select');
                    if (colorsSelectEl) {
                        for (let item of colorsSelectEl.children) {
                            if (item.hasAttribute('selected')) {
                                const color = item.getAttribute('value');
                                const colorNorm = normalizeKey(color);

                                const allThumbs = productContainer.querySelectorAll('.js-product-thumb-colors');
                                const allColors = productContainer.querySelectorAll('.js-product-colors');
                                allThumbs.forEach(addDisplayNone);
                                allColors.forEach(addDisplayNone);

                                productContainer.querySelectorAll('.js-product-thumb-colors').forEach(el => {
                                    if (el.getAttribute('data-option') === colorNorm) el.classList.remove('d-none');
                                });
                                productContainer.querySelectorAll('.js-product-colors').forEach(el => {
                                    if (el.getAttribute('data-option') === colorNorm) el.classList.remove('d-none');
                                });

                                reIndexColors();
                                break;
                            }
                        }

                        colorsSelectEl.addEventListener('change', function() {
                            const color = this.value;
                            const colorNorm = normalizeKey(color);

                            const allThumbs = productContainer.querySelectorAll('.js-product-thumb-colors');
                            const allColors = productContainer.querySelectorAll('.js-product-colors');
                            allThumbs.forEach(addDisplayNone);
                            allColors.forEach(addDisplayNone);

                            productContainer.querySelectorAll('.js-product-thumb-colors').forEach(el => {
                                if (el.getAttribute('data-option') === colorNorm) el.classList.remove('d-none');
                            });
                            productContainer.querySelectorAll('.js-product-colors').forEach(el => {
                                if (el.getAttribute('data-option') === colorNorm) el.classList.remove('d-none');
                            });

                            reIndexColors();
                        });
                    }

                    productContainer.querySelectorAll('.js-product-thumb-colors').forEach(el => {
                        el.addEventListener('click', function(e) {
                            e.preventDefault();
                            const selectedProduct = el.getAttribute('data-product-id');
                            const productSelected = productContainer.querySelector(`.js-product-colors[data-image="${selectedProduct}"]`);
                            const allProductColors = productContainer.querySelectorAll('.js-product-colors');
                            allProductColors.forEach(c => c.classList.remove('selected'));
                            productSelected.classList.add('selected');
                            productSelected.click();
                        });
                    });
                }
                productVariant();
            }
        }

        productSliderNav()

        {# /* // Pinterest sharing */ #}

        jQueryNuvem('.js-pinterest-share').on("click", function(e){
            e.preventDefault();
            jQueryNuvem(".pinterest-hidden a").get()[0].click();
        });

	{% endif %}

    {# Product quantity #}

    jQueryNuvem(document).on("click", ".js-quantity .js-quantity-up", function (e) {
        $quantity_input = jQueryNuvem(this).closest(".js-quantity").find(".js-quantity-input");
        $quantity_input.val( parseInt($quantity_input.val(), 10) + 1);
    });

    jQueryNuvem(document).on("click", ".js-quantity .js-quantity-down", function (e) {
        $quantity_input = jQueryNuvem(this).closest(".js-quantity").find(".js-quantity-input");
        quantity_input_val = $quantity_input.val();
        if (quantity_input_val>1) {
            $quantity_input.val( parseInt($quantity_input.val(), 10) - 1);
        }
    });

    {# Fancybox Instafeed #}

    {% if template == 'home' and settings.instafeed_posts == "custom" and settings.custom_feed %}

        function instafeedGallery() {
            Fancybox.bind('[data-fancybox="instafeed-gallery"]', {
                Toolbar: {
                    items: {
                        close: {
                            html: '<svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#times"/></svg>',
                        },
                        counter: {
                            class: 'pt-2 mt-1',
                            type: 'div',
                            html: '<span data-fancybox-index=""></span>&nbsp;/&nbsp;<span data-fancybox-count=""></span>',
                            position: 'center',
                        },
                    },
                },
                Carousel: {
                    Navigation: {
                        classNames: {
                            button: 'btn',
                            next: 'swiper-button-next',
                            prev: 'swiper-button-prev',
                        },
                        prevTpl: '<svg class="icon-inline icon-lg svg-icon-invert icon-flip-horizontal"><use xlink:href="#chevron"/></svg>',
                        nextTpl: '<svg class="icon-inline icon-lg svg-icon-invert"><use xlink:href="#chevron"/></svg>',
                    },
                },
                Thumbs: { autoStart: false },
            });
        }

        instafeedGallery();

    {% endif %}


	{#/*============================================================================
	  #Cart
	==============================================================================*/ #}
   
    {# /* // Free shipping bar */ #}
    
    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}

    {# /* // Cart summary */ #}

    var head_add_height = jQueryNuvem(".js-adbar").outerHeight();
    var head_logo_height = jQueryNuvem(".js-head-main").outerHeight();
    var viewport_height = window.outerHeight;
    var cart_summary_max_height = viewport_height - (head_add_height + head_logo_height); 

    jQueryNuvem(".js-cart-summary-detail").css("maxHeight" , cart_summary_max_height.toString() + 'px');

    jQueryNuvem(".js-cart-summary").on("mouseenter", function (e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).children(".js-cart-summary-detail").toggleClass("active");
    }).on("mouseleave", function (e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).children(".js-cart-summary-detail").toggleClass("active");
    });
    

    {# /* // Add to cart */ #}

    function getQuickShopImgSrc(element){
        const image = jQueryNuvem(element).closest('.js-quickshop-container').find('img');
        return String(image.attr('srcset')); 
    }

    {# /* // Product terms - add to cart */ #}

    jQueryNuvem(function() {
		jQueryNuvem('.js-product-terms').each(function() {
			var $cb = jQueryNuvem(this);
			var $container = $cb.closest('.js-product-container');
			var $btn = $container.find('.js-addtocart');
			var $alert = $container.find('.js-product-terms-alert');
			if (!$cb.prop('checked')) {
			$btn.addClass('js-addtocart-terms').prop('disabled', true).attr('aria-disabled','true');
			if ($alert.length) $alert.hide();
			} else {
			$btn.removeClass('js-addtocart-terms').prop('disabled', false).removeAttr('aria-disabled');
			if ($alert.length) $alert.hide();
			}
		});
    });

    {# Toggle on checkbox change #}
	jQueryNuvem(document).on('change', '.js-product-terms', function(){
		var $cb = jQueryNuvem(this);
		var $container = $cb.closest('.js-product-container');
		var $btn = $container.find('.js-addtocart');
		var $alert = $container.find('.js-product-terms-alert');
		if (this.checked) {
			$btn.removeClass('js-addtocart-terms').prop('disabled', false).removeAttr('aria-disabled');
			if ($alert.length) $alert.hide();
		} else {
			$btn.addClass('js-addtocart-terms').prop('disabled', true).attr('aria-disabled','true');
		}
    });

    {# Block clicks when terms not accepted (always prevent) #}
    jQueryNuvem(document).on('click', '.js-addtocart-terms', function(e){
		e.preventDefault();
		e.stopImmediatePropagation();
		var $btn = jQueryNuvem(this);
		var $container = $btn.closest('.js-product-container');
		var $alert = $container.find('.js-product-terms-alert');
		if ($alert.length) $alert.show();
		return false;
    });

    jQueryNuvem(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder, .js-addtocart-placeholder-btn, .js-addtocart-terms)", function (e) {

        {# Button variables for transitions on add to cart #}

        var $productContainer = jQueryNuvem(this).closest('.js-product-container');
        var $prod_form = jQueryNuvem(this).closest("form");
        var productId = $prod_form.find("[name='add_to_cart']").val();

        if (!$productContainer.length || !$prod_form.length || !productId) {
            return;
        }

        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("[type='submit'].js-addtocart");
        var isQuickShop = $productContainer.hasClass('js-quickshop-container');
        if (isQuickShop) {
            var $productButtonContainer = $productButton.closest(".js-item-submit-container");
        }
        var isCrossSelling = $productContainer.hasClass('js-cross-selling-container');
        var $productButtonPlaceholder = jQueryNuvem(this).siblings(".js-addtocart-placeholder, .js-addtocart-placeholder-btn");
        if (!$productButtonPlaceholder.length) {
            $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder, .js-addtocart-placeholder-btn");
        }
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Added item information for notification #}

        if (isCrossSelling) {
            var imageSrc = $productContainer.find('.js-cross-selling-product-image').attr('src');
            var quantity = $productContainer.data('quantity')
            var name = $productContainer.find('.js-cross-selling-product-name').text();
            var price = $productContainer.find('.js-cross-selling-promo-price').text();
            var addedToCartCopy = $productContainer.data('add-to-cart-translation');
        } else if (!isQuickShop) {
            if(jQueryNuvem(".js-product-slide-img.js-active-variant").length) {
                var $activeVariantImg = $productContainer.find('.js-product-slide-img.js-active-variant');
                var imageSrc = $activeVariantImg.attr('srcset') || $activeVariantImg.data('srcset');
            } else {
                var $defaultImg = $productContainer.find('.js-product-slide-img');
                var imageSrc = $defaultImg.attr('srcset') || $defaultImg.data('srcset');
            }
            
            imageSrc = imageSrc ? imageSrc.split(' ')[0] : '';
            var quantity = $productContainer.find('.js-quantity-input').val();
            var name = $productContainer.find('.js-product-name').text();
            var price = $productContainer.find('.js-price-display').text();
            var addedToCartCopy = "{{ product_button_text }}";
        } else {
            var imageSrc = getQuickShopImgSrc(this);
            {% if settings.item_quantity %}
                var quantity = $productContainer.find('.js-quantity-input').val();
            {% else %}
                var quantity = 1;
            {% endif %}
            var name = $productContainer.find('.js-item-name').text();
            var price = $productContainer.find('.js-price-display').text().trim();
            var addedToCartCopy = "{{ add_button_text }}";
            if ($productContainer.hasClass("js-quickshop-has-variants")) {
                var addedToCartCopy = "{{ product_button_text }}";
            }else{
                var addedToCartCopy = "{{ add_button_text }}";
            }
        }

        if (!jQueryNuvem(this).hasClass('contact')) {

            {% if settings.ajax_cart %}
                e.preventDefault();
            {% endif %}

            {# Hide real button and show button placeholder during event #}

            function showProductButtonPlaceholder(){
                $productButtonPlaceholder.removeClass('d-none d-block');
                $productButtonPlaceholder.addClass('d-flex');
                $productButtonPlaceholder.removeAttr('style');
            }

            function hideProductButtonPlaceholder(){
                $productButtonPlaceholder.removeClass('d-flex d-block');
                $productButtonPlaceholder.addClass('d-none');
            }

            $productButton.removeAttr('style');
            $productButton.removeClass('d-block d-flex');
            $productButton.addClass('d-none');
            if (isQuickShop) {
                $productButtonContainer.removeAttr('style');
                $productButtonContainer.removeClass('d-block');
                $productButtonContainer.addClass('d-none');
            }

            showProductButtonPlaceholder();
            $productButtonText.fadeOut();
            $productButtonAdding.addClass("active");

            {# Restore button state in case of error #}

            function restore_button_initial_state(){
                $productButtonAdding.removeClass("active");
                $productButtonSuccess.removeClass("active");
                $productButtonText.fadeIn();
                hideProductButtonPlaceholder();
                $productButton.removeClass('d-none d-block d-flex');
                if (isQuickShop) {
                    $productButtonContainer.removeClass('d-none d-block');
                }
            }

            {# Restore button state for subscriptions stock error #}

            var subscription_callback_error = function() {
                setTimeout(function() {
                    restore_button_initial_state();
                }, 500);
            };

            {# Handle subscribable product submit #}

            LS.subscriptionSubmit($productContainer, subscription_callback_error, e);

            {% if settings.ajax_cart %}

                var callback_add_to_cart = function(html_notification_related_products, html_notification_cross_selling) {

                    {# Fill notification info #}

                    jQueryNuvem('.js-cart-notification-item-img').attr('srcset', imageSrc);
                    jQueryNuvem('.js-cart-notification-item-name').text(name);
                    jQueryNuvem('.js-cart-notification-item-quantity').text(quantity);
                    jQueryNuvem('.js-cart-notification-item-price').text(price);

                    LS.updateNotificationDiscountLabel($productContainer[0]);

                    if($productVariants.length){
                        var output = [];

                        $productVariants.each( function(el){
                            var variants = jQueryNuvem(el);
                            output.push(variants.val());
                        });
                        jQueryNuvem(".js-cart-notification-item-variant-container").show();
                        jQueryNuvem(".js-cart-notification-item-variant").text(output.join(', '))
                    }else{
                        jQueryNuvem(".js-cart-notification-item-variant-container").hide();
                    }

                    {# Set products amount wording visibility #}

                    var cartItemsBadge = jQueryNuvem(".js-cart-widget-amount");
                    var cartItemsMoney = jQueryNuvem(".js-cart-widget-total");
                    var cartItemsAmount = cartItemsBadge.text();

                    cartItemsBadge.removeClass("d-none d-md-inline-block");
                    
                    if (window.innerWidth > 768) {
                        cartItemsMoney.removeClass("d-none d-md-inline-block");
                    }

                    if(cartItemsAmount > 1){
                        jQueryNuvem(".js-cart-counts-plural").show();
                        jQueryNuvem(".js-cart-counts-singular").hide();
                    }else{
                        jQueryNuvem(".js-cart-counts-singular").show();
                        jQueryNuvem(".js-cart-counts-plural").hide();
                    }

                    {# Show button placeholder with transitions #}

                    $productButtonAdding.removeClass("active");
                    $productButtonSuccess.addClass("active");
                    showProductButtonPlaceholder();
                    setTimeout(function(){
                        hideProductButtonPlaceholder();
                        $productButtonSuccess.removeClass("active");
                        $productButton.removeClass('d-none d-block d-flex');
                        if (isQuickShop) {
                            $productButtonContainer.removeClass('d-none d-block');
                        }
                    }, 3000);

                    $productContainer.find(".js-added-to-cart-product-message").slideDown();

                    if (isQuickShop) {
                        jQueryNuvem("#quickshop-modal").removeClass('modal-show');
                        jQueryNuvem(".js-modal-overlay[data-modal-id='#quickshop-modal']").hide();
                        jQueryNuvem("body").removeClass("overflow-none");
                        restoreQuickshopForm();
                        if (window.innerWidth < 768) {
                            cleanURLHash();
                        }
                    }

                    {# Toggle cart panel on add to cart #}

                    {% if settings.cart_toggle and not settings.add_to_cart_recommendations %}

                    setTimeout(function(){

                        e.preventDefault(); 
                        var modal_id = jQueryNuvem('#modal-cart');
                        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="#modal-cart"]');

                        if (jQueryNuvem(modal_id).hasClass("modal-show")) {
                            {# If modal is already opened, close it #}
                            if(jQueryNuvem(".js-modal.modal-show").length == 1){
                                jQueryNuvem("body").removeClass("overflow-none");
                            }
                            let modal = jQueryNuvem(modal_id).removeClass("modal-show");
                            setTimeout(() => modal.hide(), 500);
                        } else {

                            {# Lock body scroll if there is no modal visible on screen #}
                            
                            if(!jQueryNuvem(".js-modal.modal-show").length){
                                jQueryNuvem("body").addClass("overflow-none move-right");
                            }

                            jQueryNuvem(modal_id).detach().appendTo("body");
                            jQueryNuvem(modal_id).show().addClass("modal-show");
                            
                            {# Show overlay for all modals or tab modals only in desktop #}
                            if (((jQueryNuvem(modal_id).hasClass("js-modal-overlay-md")) && (window.innerWidth > 768)) || (!jQueryNuvem(modal_id).hasClass("js-modal-overlay-md"))) {
                                $overlay_id.fadeIn(400);
                                $overlay_id.detach().insertBefore(modal_id);
                            }

                            {# Add hash on mobile #}
                            if (window.innerWidth < 768) {
                                window.location.hash = "modal-fullscreen-cart";
                            }
                        }

                    },500);

                    {% endif %}

                    let notificationWithRelatedProducts = false;

                    {% if settings.add_to_cart_recommendations %}

                        {# Show added to cart product related products #}

                        function recommendProductsOnAddToCart(){

                            jQueryNuvem('.js-related-products-notification-container').html("");

                            modalOpen('#related-products-notification');

                            jQueryNuvem('.js-related-products-notification-container').html(html_notification_related_products).show();

                            {# Recommendations swiper #}

                            // Set loop for recommended products

                            function calculateRelatedNotificationLoopVal(sectionSelector) {
                                let productsAmount = jQueryNuvem(sectionSelector).attr("data-related-amount");
                                let loopVal = false;
                                const applyLoop = (window.innerWidth < 768 && productsAmount > 2.5) || (window.innerWidth > 768 && productsAmount > 4);
                                
                                if (applyLoop) {
                                    loopVal = true;
                                }
                                
                                return loopVal;
                            }

                            let cartRelatedLoopVal = calculateRelatedNotificationLoopVal(".js-related-products-notification");

                            // Create new swiper on add to cart

                            createSwiper('.js-swiper-related-products-notification', {
                                lazy: true,
                                loop: cartRelatedLoopVal,
                                watchOverflow: true,
                                threshold: 5,
                                watchSlideProgress: true,
                                watchSlidesVisibility: true,
                                spaceBetween: itemSwiperSpaceBetween,
                                slideVisibleClass: 'js-swiper-slide-visible',
                                slidesPerView: 2.5,
                                navigation: {
                                    nextEl: '.js-swiper-related-products-notification-next',
                                    prevEl: '.js-swiper-related-products-notification-prev',
                                },
                                on: {
                                    afterInit: function () {
                                        hideSwiperControls(".js-swiper-related-products-notification-prev", ".js-swiper-related-products-notification-next");
                                    },
                                },
                                breakpoints: {
                                    768: {
                                        slidesPerView: 3,
                                    }
                                }
                            });
                        }
                        
                        notificationWithRelatedProducts = html_notification_related_products != null;

                        if(notificationWithRelatedProducts){
                            if (isQuickShop) {
                                setTimeout(function(){
                                    recommendProductsOnAddToCart();
                                },300);
                            }else{
                                recommendProductsOnAddToCart();
                            }
                        }

                    {% endif %}

                    {# Show added to cart notification #}

                    if(!notificationWithRelatedProducts){

                        setTimeout(function(){
                            jQueryNuvem(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");

                        },500);

                        {% if settings.cart_notification_first %}
                            if (!cookieService.get('first_product_added_successfully')) {
                                cookieService.set('first_product_added_successfully', 1, 7 );
                            } else{
                                setTimeout(function(){
                                    jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                                    setTimeout(function(){
                                        jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
                                        jQueryNuvem(".js-alert-added-to-cart").hide();
                                    },2000);
                                },8000);
                            }
                        {% else %}
                            setTimeout(function(){
                                jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                                setTimeout(function(){
                                    jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
                                    jQueryNuvem(".js-alert-added-to-cart").hide();
                                },2000);
                            },3000);
                        {% endif %}
                    }

                    {# Display cross-selling promotion modal #}

                    if (html_notification_cross_selling != null) {
                        jQueryNuvem('.js-cross-selling-modal-body').html("");
                        modalOpen('#js-cross-selling-modal');
                        jQueryNuvem('.js-cross-selling-modal-body').html(html_notification_cross_selling).show();
                    }

                    {# Change prices on cross-selling promotion modal #}

                    const crossSellingContainer = document.querySelector('.js-cross-selling-container');

                    if (crossSellingContainer) {
                        LS.fillCrossSelling(crossSellingContainer);
                    }

                    {# Update shipping input zipcode on add to cart #}

                    {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                    if (jQueryNuvem("#product-shipping-container .js-shipping-input").val()) {
                        zipcode_on_addtocart = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
                        jQueryNuvem("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                    } else if (cookieService.get('calculator_zipcode')){
                        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                        jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                    }


                    {# Update free shipping wording #}

                    jQueryNuvem(".js-fs-add-this-product").hide();
                    jQueryNuvem(".js-fs-add-one-more").show();

                    {# Automatically close the cross-selling modal by triggering its close button #}

                    if (isCrossSelling) {
                        jQueryNuvem('#js-cross-selling-modal .js-modal-close').trigger('click');
                    }

                }
                var callback_error = function(){
                    {# Restore real button visibility in case of error #}
                    restore_button_initial_state();
                }
                LS.addToCartEnhanced(
                    $prod_form,
                    addedToCartCopy,
                    '{{ "Agregando..." | translate }}',
                    '{{ "No hay más stock de este producto." | translate }}',
                    {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                        callback_add_to_cart,
                        callback_error
                );
            {% endif %}
        }
    });


    {# /* // Cart quantitiy changes */ #}

    jQueryNuvem(document).on("keypress", ".js-cart-quantity-input", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    jQueryNuvem(document).on("focusout", ".js-cart-quantity-input", function (e) {
        var itemID = jQueryNuvem(this).attr("data-item-id");
        var itemVAL = jQueryNuvem(this).val();
        if (itemVAL == 0) {
            var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
            if (r == true) {
                LS.removeItem(itemID, true);
            } else {
                jQueryNuvem(this).val(1);
            }
        } else {
            LS.changeQuantity(itemID, itemVAL, true);
        }
    });

    {# /* // Empty cart alert */ #}

    jQueryNuvem(".js-trigger-empty-cart-alert").on("click", function (e) {
        e.preventDefault();
        let emptyCartAlert = jQueryNuvem(".js-mobile-nav-empty-cart-alert").fadeIn(100);
        setTimeout(() => emptyCartAlert.fadeOut(500), 1500);
    });

    {# /* // Go to checkout */ #}

    {# Clear cart notification cookie after consumers continues to checkout #}

    jQueryNuvem('form[action="{{ store.cart_url | escape('js') }}"]').on("submit", function() {
        cookieService.remove('first_product_added_successfully');
    });


    {#/*============================================================================
	  #Shipping calculator
	==============================================================================*/ #}

    {# /* // Update calculated cost wording */ #}

    {% if settings.shipping_calculator_cart_page %}
        if (jQueryNuvem('.js-selected-shipping-method').length) {
            LS.ShippingDiscountRow.apply(jQueryNuvem('.js-selected-shipping-method')[0], {});
            jQueryNuvem("#shipping-cost").removeClass('opacity-40');
        }
    {% endif %}

	{# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        jQueryNuvem(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        jQueryNuvem(elem).addClass('js-selected-shipping-method');

        {% if settings.shipping_calculator_cart_page %}
            LS.ShippingDiscountRow.apply(elem, {});
            jQueryNuvem("#shipping-cost").removeClass('opacity-40');

        {% endif %}

        if (save_option) {
            LS.saveCalculatedShipping(true);
        }
        if (jQueryNuvem(elem).hasClass("js-shipping-method-hidden")) {
            {# Toggle other options visibility depending if they are pickup or delivery for cart and product at the same time #}
            if (jQueryNuvem(elem).hasClass("js-pickup-option")) {
                jQueryNuvem(".js-other-pickup-options, .js-show-other-pickup-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-more").hide();
            } else {
                jQueryNuvem(".js-other-shipping-options, .js-show-more-shipping-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-more").hide()
            }
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to triggert automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');

        {% if settings.ajax_cart %}

            {# If ajax cart is active, target only product input to avoid extra calulation on empty cart #}

            jQueryNuvem('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);

        {% else %}

            {# If ajax cart is inactive, target the only input present on screen #}

            jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);

        {% endif %}

        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        jQueryNuvem(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-spinner").show();
    } else {

        {# If there is no cookie saved, show calcualtor #}

        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = jQueryNuvem(".js-modal-shipping-suboptions").attr("id");
        jQueryNuvem("#" + shipping_suboptions_id).remove();
        jQueryNuvem('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Calculate shipping function */ #}

    jQueryNuvem(".js-calculate-shipping").on("click", function (e) {
	    e.preventDefault();

        {# Take the Zip code to all shipping calculators on screen #}
        let shipping_input_val = jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        jQueryNuvem(".js-shipping-input").val(shipping_input_val);

        {# Calculate on page load for both calculators: Product and Cart #}

        if (jQueryNuvem(".js-cart-item").length) {
            LS.calculateShippingAjax(
            jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
            '{{store.shipping_calculator_url | escape('js')}}',
            jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
        }

        jQueryNuvem(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();
	});

	{# /* // Calculate shipping by submit */ #}

    jQueryNuvem(".js-shipping-input").on('keydown', function (e) {
	    var key = e.which ? e.which : e.keyCode;
	    var enterKey = 13;
	    if (key === enterKey) {
	        e.preventDefault();
            jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-calculate-shipping").trigger('click');
	        if (window.innerWidth < 768) {
                jQueryNuvem(e.currentTarget).trigger('blur');
	        }
	    }
	});

    {# /* // Shipping and branch click */ #}

    jQueryNuvem(document).on("change", ".js-shipping-method, .js-branch-method", function (e) {
        selectShippingOption(this, true);
        jQueryNuvem(".js-shipping-method-unavailable").hide();
    });

    {# /* // Select shipping first option on results */ #}

    jQueryNuvem(document).on('shipping.options.checked', '.js-shipping-method', function (e) {
        let shippingPrice = jQueryNuvem(this).attr("data-price");
        LS.addToTotal(shippingPrice);

        let total = (LS.data.cart.total / 100) + parseFloat(shippingPrice);
        jQueryNuvem(".js-cart-widget-total").html(LS.formatToCurrency(total));

        selectShippingOption(this, false);
    });

    {# /* // Toggle more shipping options */ #}

    jQueryNuvem(document).on("click", ".js-toggle-more-shipping-options", function(e) {
	    e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if(jQueryNuvem(this).hasClass("js-show-other-pickup-options")){
            jQueryNuvem(".js-other-pickup-options").slideToggle(600);
            jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            jQueryNuvem(".js-other-shipping-options").slideToggle(600);
            jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
	});

    {# /* // Calculate shipping on page load */ #}

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function() {
        {# Triggers function when a zipcode input is filled #}
        if (jQueryNuvem("#cart-shipping-container .js-shipping-input").val()) {
            // If user already had calculated shipping: recalculate shipping
            setTimeout(function() {
                LS.calculateShippingAjax(
                    jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
                removeShippingSuboptions();
                window.toggleAccordionPrivate("#cart-shipping-container .js-toggle-shipping");
            }, 100);
        }

        if (jQueryNuvem(".js-branch-method").hasClass('js-selected-shipping-method')) {
            {% if store.branches|length > 1 %}
                window.toggleAccordionPrivate("#cart-shipping-container .js-toggle-branches");
            {% endif %}
        }
    };

    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}

    {# /* // Change CP */ #}

    jQueryNuvem(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        jQueryNuvem(".js-shipping-calculator-response").fadeOut(100);
        jQueryNuvem(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    });

	{# /* // Shipping provinces */ #}

	{% if provinces_json %}
        jQueryNuvem('select[name="country"]').on("change", function (e) {
		    var provinces = {{ provinces_json | default('{}') | raw }};
		    LS.swapProvinces(provinces[jQueryNuvem(e.currentTarget).val()]);
		}).trigger('change');
	{% endif %}


    {# /* // Change store country: From invalid zipcode message */ #}

    jQueryNuvem(document).on("click", ".js-save-shipping-country", function(e) {

        e.preventDefault();

        {# Change shipping country #}

        lang_select_option = jQueryNuvem(this).closest(".js-modal-shipping-country");
        changeLang(lang_select_option);

        jQueryNuvem(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });


    {#/*============================================================================
      #Forms
    ==============================================================================*/ #}

    {# IOS form CSS to avoid autozoom on focus #}

    var isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
    if (isIOS) {
        var ios_input_fields = jQueryNuvem("input[type='text'], input[type='number'], input[type='password'], input[type='tel'], textarea, input[type='search'], input[type='hidden'], input[type='email']");
        ios_input_fields.addClass("form-control-ios");
        jQueryNuvem(".js-quantity").addClass("form-group-quantity-ios");
        jQueryNuvem(".js-cart-quantity-container").addClass("cart-quantity-container-ios");
        jQueryNuvem(".js-search-form").toggleClass("search-form-ios");
        jQueryNuvem(".js-price-filter-btn").addClass("price-btn-ios");
        jQueryNuvem(".js-price-filter-empty").addClass("input-clear-content-ios");
    }

    jQueryNuvem(".js-winnie-pooh-form").on("submit", function (e) {
        jQueryNuvem(e.currentTarget).attr('action', '');
    });

    jQueryNuvem(".js-form").on("submit", function (e) {
        jQueryNuvem(e.currentTarget).find('.js-form-spinner').show();
    });

    {% if template == 'account.login' %}
        {% if not result.facebook and result.invalid %}
            jQueryNuvem(".js-account-input").addClass("alert-danger");
            jQueryNuvem(".js-account-input.alert-danger").on("focus", function() {
                jQueryNuvem(".js-account-input").removeClass("alert-danger");
            });
        {% endif %}
    {% endif %}

    {# Show the success or error message when resending the validation link #}

    {% if template == 'account.register' or template == 'account.login' %}
        jQueryNuvem(".js-resend-validation-link").on("click", function(e){
            window.accountVerificationService.resendVerificationEmail('{{ customer_email }}');
        });
    {% endif %}

    jQueryNuvem('.js-password-view').on("click", function (e) {
        jQueryNuvem(e.currentTarget).toggleClass('password-view');

        if(jQueryNuvem(e.currentTarget).hasClass('password-view')){
            jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', '');
            jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
        } else {
            jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', 'password');
            jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
        }
    });

    {% if store.country == 'AR' and template == 'home' %}

        if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
            {# Make login link toggle quick login modal #}
            jQueryNuvem(".js-login").removeAttr("href").attr("data-toggle", "#quick-login").addClass("js-modal-open js-trigger-modal-zindex-top");
        }
    {% endif %}


    {#/*============================================================================
      #Footer
    ==============================================================================*/ #}

    {% if store.afip %}

        {# Add alt attribute to external AFIP logo to improve SEO #}

        jQueryNuvem('img[src*="www.afip.gob.ar"]').attr('alt', '{{ "Logo de AFIP" | translate }}');

    {% endif %}

    {#/*============================================================================
      #Empty placeholders
    ==============================================================================*/ #}

    {% if template == 'home' %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var slider_empty_autoplay = {delay: 6000,};
        } else {
            var slider_empty_autoplay = false;
        }

        window.homeEmptySlider = {
            getAutoRotation: function() {
                return slider_empty_autoplay;
            },
        };
        createSwiper('.js-home-empty-slider', {
            {% if not params.preview %}
            lazy: true,
            {% endif %}
            loop: true,
            autoplay: slider_empty_autoplay,
            pagination: {
                el: '.js-swiper-empty-home-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-empty-home-next',
                prevEl: '.js-swiper-empty-home-prev',
            },
            on: {
                init: function () {
                    jQueryNuvem(".js-home-empty-slider").css("visibility", "visible").css("height", "100%");
                },
            },
        });

        {# /* // Banner services slider */ #}

        var width = window.innerWidth;
        if (width < 767) {   
            createSwiper('.js-informative-banners-demo', {
                autoplay: true,
                speed: 1600,
                navigation: {
                    nextEl: '.js-informative-banners-demo-next',
                    prevEl: '.js-informative-banners-demo-prev',
                },
            });
        }

        {# /* // Home demo products slider */ #}

        var lazyVal = true;
        var watchOverflowVal = true;
        {% if columns_mobile == 2 %}
        var centeredSlidesVal = false;
        {% else %}
        var centeredSlidesVal = true;
        {% endif %}
        var centerInsufficientSlidesVal = true;
        var breakpointsInverseVal = true;
        var slidesPerViewDesktopVal = {{ columns_desktop }};
        {% if settings.show_horizontal %}
            var slidesPerViewMobileVal = 1.2;
        {% else %}
            var slidesPerViewMobileVal = {% if columns_mobile == 2 %}2.2{% else %}1.5{% endif %};
        {% endif %}

        createSwiper('.js-swiper-featured-demo', {
            lazy: lazyVal,
            watchOverflow: watchOverflowVal,
            centeredSlides: centeredSlidesVal,
            centerInsufficientSlides: centerInsufficientSlidesVal,
            spaceBetween: 10,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            slideVisibleClass: 'js-swiper-slide-visible',
            {% if sections.primary.products | length > 3 %}
                loop: true,
            {% endif %}
            navigation: {
                nextEl: '.js-swiper-featured-demo-next',
                prevEl: '.js-swiper-featured-demo-prev',
            },
            slidesPerView: slidesPerViewMobileVal,
            breakpointsInverse: breakpointsInverseVal,
            breakpoints: {
                768: {
                    slidesPerView: 2,
                    {% if not settings.featured_products_scroll %}
                    slidesPerGroup: 2,
                    {% endif %}
                    centeredSlides: false,
                    pagination: {
                        el: '.js-swiper-featured-demo-pagination',
                    }
                },
                992: {
                    slidesPerView: 3,
                    {% if not settings.featured_products_scroll %}
                    slidesPerGroup: 3,
                    {% endif %}
                    centeredSlides: false,
                },
                1199: {
                    slidesPerView: slidesPerViewDesktopVal,
                    {% if not settings.featured_products_scroll %}
                    slidesPerGroup: slidesPerViewDesktopVal,
                    {% endif %}
                    centeredSlides: false,
                }
            }
        });

        {# /* // Categories slider */ #}

        createSwiper('.js-swiper-categories-demo', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            spaceBetween: 16,
            navigation: {
                nextEl: '.js-swiper-categories-demo-next',
                prevEl: '.js-swiper-categories-demo-prev',
            },
            pagination: {
                el: '.swiper-categories-demo-slide-pagination',
            },
            slidesPerView: 2.25,
            breakpoints: {
                768: {
                    slidesPerView: 4,
                },
                990: {
                    slidesPerView: 8,
                },
            }
        });

        {# /* // Testimonials slider */ #}

        createSwiper('.js-home-testimonials-demo', {
            lazy: true,
            watchOverflow: true,
            centeredSlides: false,
            centerInsufficientSlides: true,
            spaceBetween: 0,
            loop: false,
            navigation: {
                nextEl: '.js-swiper-testimonials-demo-next',
                prevEl: '.js-swiper-testimonials-demo-prev',
            },
            pagination: {
                el: '.js-testimonials-demo-pagination',
            },
            slidesPerView: 1,
            breakpoints: {
                768: {
                    slidesPerView: 1,
                    centeredSlides: false,
                    navigation: { enabled: false },
                },
                992: {
                    slidesPerView: 3,
                    slidesPerGroup: 3,
                    centeredSlides: false,
                },
                1199: {
                    slidesPerView: 4,
                    slidesPerGroup: 4,
                    centeredSlides: false,
                }
            }
        });       

        var slidesPerViewSelectionMobileVal = {% if banner_products_columns_mobile == 1 %}1.5{% else %}2.25{% endif %};
        var slidesPerViewSelectionDesktopVal = 3;
        
        window.swiperLoader('.js-swiper-promos-demo', {
            lazy: lazyVal,
            watchOverflow: watchOverflowVal,
            centeredSlides: false,
            centerInsufficientSlides: centerInsufficientSlidesVal,
            spaceBetween: itemSwiperSpaceBetween,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            slideVisibleClass: 'js-swiper-slide-visible',
            loop: true,
            navigation: {
                nextEl: '.js-swiper-promos-demo-next',
                prevEl: '.js-swiper-promos-demo-prev',
            },
            slidesPerView: slidesPerViewSelectionMobileVal,
            breakpointsInverse: slidesPerViewSelectionMobileVal,
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewSelectionMobileVal,
                    {% if settings.banner_products_scroll_quantity == "all" %}
                        slidesPerGroup: slidesPerViewSelectionMobileVal,
                    {% endif %}
                    centeredSlides: false,
                    spaceBetween: itemDesktopSpaceBetween,
                },
                992: {
                    slidesPerView: slidesPerViewSelectionDesktopVal,
                    {% if settings.banner_products_scroll_quantity == "all" %}
                        slidesPerGroup: slidesPerViewSelectionDesktopVal,
                    {% endif %}
                    centeredSlides: false,
                },
                1199: {
                    slidesPerView: slidesPerViewSelectionDesktopVal,
                    {% if settings.banner_products_scroll_quantity == "all" %}
                        slidesPerGroup: slidesPerViewSelectionDesktopVal,
                    {% endif %}
                    centeredSlides: false,
                }
            }
        });

    {% endif %}

    {# Image and text modules #}

    {% if (settings.module_format_mobile == 'slider' or settings.module_format_desktop == 'slider' or theme_editor and (settings.module and settings.module is not empty)) or theme_editor %}

        {% set module_desktop_slider = settings.module_format_desktop == 'slider' %}
        {% set module_only_mobile_slider = settings.module_format_mobile == 'slider' and settings.module_format_desktop != 'slider' %}
        {% set module_only_desktop_slider = settings.module_format_desktop == 'slider' and settings.module_format_mobile != 'slider' %}
        {% set module_columns_desktop = settings.module_columns_desktop %}
        {% set module_slider_autoplay = settings.module_slide_autoplay_desktop or settings.module_slide_autoplay_mobile %}

        var modulesPerViewDesktopVal = {{ module_columns_desktop }};

        {% if module_only_mobile_slider %}
            if (window.innerWidth < 768) {
        {% elseif module_only_desktop_slider %}
            if (window.innerWidth > 768) {
        {% endif %}

            createSwiper('.js-swiper-modules', {
                lazy: true,
                watchOverflow: true,
                threshold: 5,
                watchSlideProgress: true,
                watchSlidesVisibility: true,
                {% if settings.module_slide_mobile_centered %}
                    centeredSlides: true,
                {% endif %}
                loop: false,
                slideVisibleClass: 'js-swiper-slide-visible',
                spaceBetween: itemSwiperSpaceBetween,
                centerInsufficientSlides: true,
                navigation: {
                    nextEl: '.js-swiper-modules-next',
                    prevEl: '.js-swiper-modules-prev',
                },
                slidesPerView: 1.25,
                {% if module_slider_autoplay %}
                    autoplay: true,
                {% endif %}
                pagination: {
                    el: '.js-swiper-modules-pagination',
                },
                {% if module_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: modulesPerViewDesktopVal,
                            slidesPerGroup: modulesPerViewDesktopVal,
                            centeredSlides: false,
                        }
                    },
                {% endif %}
                on: {
                    afterInit: function () {
                        hideSwiperControls(".js-swiper-modules-prev", ".js-swiper-modules-next");
                    },
                },
            },
            function(swiperInstance) {
                window.homeModuleSwiper = swiperInstance;
            });

        {% if module_only_mobile_slider or module_only_desktop_slider %}
            }
        {% endif %}

    {% endif %}

    {# /* // Categories slider */ #}

    {% if settings.slider_categories and settings.slider_categories is not empty %}

        {% set main_categories_columns_desktop = settings.main_categories_columns_desktop %}
        {% set main_categories_columns_mobile = settings.main_categories_columns_mobile %}

        var bannersPerViewDesktopVal = {% if main_categories_columns_desktop == 10 %}10{% elseif main_categories_columns_desktop == 8 %}8{% elseif main_categories_columns_desktop == 6 %}6{% elseif main_categories_columns_desktop == 5 %}5{% elseif main_categories_columns_desktop == 4 %}4{% elseif main_categories_columns_desktop == 3 %}3{% elseif main_categories_columns_desktop == 2 %}2{% else %}1{% endif %};
        var bannersPerViewMobileVal = {% if main_categories_columns_mobile == 3 %}2.9{% elseif main_categories_columns_mobile == 2 %}2.25{% else %}1.5{% endif %};

        createSwiper('.js-swiper-categories', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            centerInsufficientSlides: true,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: bannersPerViewMobileVal,
            slidesPerGroup: {{ main_categories_columns_mobile }},
            navigation: {
                nextEl: '.js-swiper-categories-next',
                prevEl: '.js-swiper-categories-prev',
            },
            pagination: {
                el: '.swiper-categories-slide-pagination',
            },
            breakpoints: {
                768: {
                    slidesPerView: bannersPerViewDesktopVal,
                    slidesPerGroup: bannersPerViewDesktopVal,
                }
            }
        });

    {% endif %}

    {# /* // Banners slider */ #}

    {# Category banners #}

    {% if settings.banner_format_mobile == 'slider' or settings.banner_format_desktop == 'slider' and (settings.banner and settings.banner is not empty) %}

        {% set banner_desktop_slider = settings.banner_format_desktop == 'slider' %}
        {% set banner_only_mobile_slider = settings.banner_format_mobile == 'slider' and settings.banner_format_desktop != 'slider' %}
        {% set banner_only_desktop_slider = settings.banner_format_desktop == 'slider' and settings.banner_format_mobile != 'slider' %}
        {% set banner_columns_desktop = settings.banner_columns_desktop %}

        var bannersPerViewDesktopVal = {% if banner_columns_desktop == 4 %}4{% elseif banner_columns_desktop == 3 %}3{% elseif banner_columns_desktop == 2 %}2{% else %}1{% endif %};
        var bannersSpaceBetween = {% if settings.banner_without_margins %}0{% else %}itemSwiperSpaceBetween{% endif %};

        {% if banner_only_mobile_slider %}
            if (window.innerWidth < 768) {
        {% elseif banner_only_desktop_slider %}
            if (window.innerWidth > 768) {
        {% endif %}

            {# General banners #}

            {% if (settings.banner and settings.banner is not empty) or theme_editor %}

                createSwiper('.js-swiper-banners', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-next',
                        prevEl: '.js-swiper-banners-prev',
                    },
                    slidesPerView: 1.5,
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-prev", ".js-swiper-banners-next");
                        },
                    },
                {% if banner_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersPerViewDesktopVal,
                        }
                    }
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerSwiper = swiperInstance;
                });

            {% endif %}

            {# Mobile banners #}

            {% if (settings.toggle_banner_mobile and settings.banner_mobile and settings.banner_mobile is not empty) or theme_editor %}
                createSwiper('.js-swiper-banners-mobile', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-mobile-next',
                        prevEl: '.js-swiper-banners-mobile-prev',
                    },
                    slidesPerView: 1.15,
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-mobile-prev", ".js-swiper-banners-mobile-next");
                        },
                    },
                {% if banner_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersPerViewDesktopVal,
                        }
                    },
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerMobileSwiper = swiperInstance;
                });
            {% endif %}

        {% if banner_only_mobile_slider or banner_only_desktop_slider %}
            }
        {% endif %}

    {% endif %}

    {# Promotional banners #}

    {% if settings.banner_promotional_format_mobile == 'slider' or settings.banner_promotional_format_desktop == 'slider' and (settings.banner_promotional and settings.banner_promotional is not empty) %}

        {% set banner_desktop_slider = settings.banner_promotional_format_desktop == 'slider' %}
        {% set banner_only_mobile_slider = settings.banner_promotional_format_mobile == 'slider' and settings.banner_promotional_format_desktop != 'slider' %}
        {% set banner_only_desktop_slider = settings.banner_promotional_format_desktop == 'slider' and settings.banner_promotional_format_mobile != 'slider' %}
        {% set banner_columns_desktop = settings.banner_promotional_columns_desktop %}

        var bannersPromotionalPerViewDesktopVal = {% if banner_columns_desktop == 4 %}4{% elseif banner_columns_desktop == 3 %}3{% elseif banner_columns_desktop == 2 %}2{% else %}1{% endif %};
        var bannersPromotionalSpaceBetween = {% if settings.banner_without_margins %}0{% else %}itemSwiperSpaceBetween{% endif %};

        {% if banner_only_mobile_slider %}
            if (window.innerWidth < 768) {
        {% elseif banner_only_desktop_slider %}
            if (window.innerWidth > 768) {
        {% endif %}

            {# General banners #}

            {% if (settings.banner_promotional and settings.banner_promotional is not empty) or theme_editor %}
                createSwiper('.js-swiper-banners-promotional', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersPromotionalSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-promotional-next',
                        prevEl: '.js-swiper-banners-promotional-prev',
                    },
                    slidesPerView: 1.5,
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-promotional-prev", ".js-swiper-banners-promotional-next");
                        },
                    },
                {% if banner_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersPromotionalPerViewDesktopVal,
                        }
                    }
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerPromotionalSwiper = swiperInstance;
                });
            {% endif %}

            {# Mobile banners #}

            {% if (settings.toggle_banner_promotional_mobile and settings.banner_promotional_mobile and settings.banner_promotional_mobile is not empty) or theme_editor %}
                createSwiper('.js-swiper-banners-promotional-mobile', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersPromotionalSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-promotional-mobile-next',
                        prevEl: '.js-swiper-banners-promotional-mobile-prev',
                    },
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-promotional-mobile-prev", ".js-swiper-banners-promotional-mobile-next");
                        },
                    },
                    slidesPerView: 1.15,
                {% if banner_promotional_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersPromotionalPerViewDesktopVal,
                        }
                    },
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerPromotionalMobileSwiper = swiperInstance;
                });
            {% endif %}

        {% if banner_only_mobile_slider or banner_only_desktop_slider %}
            }
        {% endif %}

    {% endif %}    

    {# /* // Slider Categories */ #}

    createSwiper('.js-category-swiper', {
        lazy: true,
        watchOverflow: true,
        spaceBetween: 0,
        slidesPerView: 1.3,
        navigation: {
            nextEl: '.js-category-next',
            prevEl: '.js-category-prev',
        },
        breakpointsInverse: true,
        breakpoints: {
            640: {
                slidesPerView: {% if settings.home_categories_quantity == 3 %}3{% elseif settings.home_categories_quantity == 4 %}4{% elseif settings.home_categories_quantity == 6 %}6{% else %}8{% endif %},
                autoplay: true,
            },
            500: {
                sliderPerView: 3,
            }
        }
    });

    {% if template == '404' or template == 'home' %}

        {# /* // Product slider */ #}

        createSwiper('.js-swiper-product-demo', {
            lazy: true,
            slidesPerView: 'auto',
            watchOverflow: true,
            navigation: {
                nextEl: '.js-swiper-product-next-demo',
                prevEl: '.js-swiper-product-prev-demo',
            },
            pagination: {
                el: '.js-swiper-product-pagination-demo',
            },
            breakpoints: {
                768: {
                    slidesPerView: 'auto',
                }
            },
        });

        var directionVal = 'vertical';

        {% if template == 'product' %}
            if (window.innerWidth < 767) {
                var directionVal = 'horizontal';
            }
        {% endif %}

        createSwiper('.js-swiper-product-thumbs-demo', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            direction: directionVal,
            navigation: {
                nextEl: '.js-swiper-product-thumbs-next-demo',
                prevEl: '.js-swiper-product-thumbs-prev-demo',
            },
            slidesPerView: 'auto',
        });

    {% endif %}

    {% if template == '404' %}

        {# /* // Product Related */ #}
        
        {% if settings.show_horizontal %}
            var slidesPerViewMobileVal = 1.2;
        {% else %}
            var slidesPerViewMobileVal = {% if columns_mobile == 2 %}2.2{% else %}1.5{% endif %};
        {% endif %}

        createSwiper('.js-swiper-related', {
            lazy: true,
            loop: true,
            centerInsufficientSlides: true,
            spaceBetween: 10,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: slidesPerViewMobileVal,
            pagination: {
                el: '.js-swiper-related-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            breakpointsInverse: true,
            breakpoints: {
                767: {
                    slidesPerView: {% if columns_desktop == 5 %}5{% elseif columns_desktop == 4 %}4{% else %}3{% endif %},
                    slidesPerGroup: {% if columns_desktop == 5 %}5{% elseif columns_desktop == 4 %}4{% else %}3{% endif %},
                }
            }
        });

        {# /* // Product slider */ #}

        var width = window.innerWidth;
        if (width > 767) {  
            var speedVal = 0;
            var loopVal = false;
            var spaceBetweenVal = 0;
            var slidesPerViewVal = 1;
        } else {
            var speedVal = 300;
            var loopVal = true;
            var spaceBetweenVal = 10;
            var slidesPerViewVal = 1.2;
        }

        createSwiper('.js-swiper-product', {
            lazy: true,
            speed: speedVal,
            {% if product.images_count > 1 %}
            loop: loopVal,
            slidesPerView: slidesPerViewVal,
            centeredSlides: true,
            spaceBetween: spaceBetweenVal,
            {% endif %}
            pagination: {
                el: '.js-swiper-product-pagination',
                type: 'fraction',
                clickable: true,
            },
            on: {
                init: function () {
                    jQueryNuvem(".js-product-slider-placeholder").hide();
                    jQueryNuvem(".js-swiper-product").css("visibility", "visible").css("height", "auto");
                },
            },
        }); 

        {# /* 404 handling to show the example product */ #}

        if ( window.location.pathname === "/product/example/" || window.location.pathname === "/br/product/example/" ) {
            document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
            jQueryNuvem("#404").hide();
            jQueryNuvem("#product-example").show();
        } else {
            jQueryNuvem("#product-example").hide();
        }

    {% endif %}


    {% if store.country == "BR" %}

        {# WhatsApp Mask #}
        // Select all elements with the .contact-whatsapp class
        var whatsappLinks = document.querySelectorAll(".contact-whatsapp");

        // Loop through all WhatsApp links and format the phone numbers
        whatsappLinks.forEach(function(linkElement) {
            // Get the full URL from the href attribute
            var fullUrl = linkElement.getAttribute("href");

            // Extract the phone number from the URL
            var phoneNumber = fullUrl.match(/https:\/\/wa.me\/(\d+)/);

            if (phoneNumber) {
                // Remove the country code (assuming the first two digits are the country code)
                var rawNumber = phoneNumber[1].substr(2);

                if (rawNumber.length > 11) {
                    linkElement.textContent = "WhatsApp";
                } else if (rawNumber.length === 10) {
                    // If the number has 8 digits after the area code (10 digits total), format as (XX) XXXX-XXXX
                    var formattedNumber = "(" + rawNumber.substr(0, 2) + ") " + rawNumber.substr(2, 4) + "-" + rawNumber.substr(6);
                    linkElement.textContent = formattedNumber;
                } else if (rawNumber.length === 11) {
                    // If the number has 9 digits after the area code (11 digits total), format as (XX) XXXXX-XXXX
                    var formattedNumber = "(" + rawNumber.substr(0, 2) + ") " + rawNumber.substr(2, 5) + "-" + rawNumber.substr(7);
                    linkElement.textContent = formattedNumber;
                }
            }
        });

    {% endif %}

});
