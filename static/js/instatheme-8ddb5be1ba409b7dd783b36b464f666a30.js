window.tiendaNubeInstaTheme = (function(jQueryNuvem) {
	return {
		waitFor: function() {
			return [];
		},
		handlers: function(instaElements) {
			return {
				logo: new instaElements.Logo({
					$storeName: jQueryNuvem('#no-logo'),
					$logo: jQueryNuvem('#logo')
				}),
                // ----- Section order -----
                home_order_position: new instaElements.Sections({
                    container: '.js-home-sections-container',
                    data_store: {
						'slider': 'home-slider',
						'informatives': 'banner-services',
						'main_categories': 'home-categories-featured',
						'categories': 'home-banner-categories',
						'promotional': 'home-banner-promotional',
						'grid': 'home-grid-banners',
						'featured_banner': 'home-banner-featured',
						'banner_products': 'home-banner-products',
						'products': 'home-products-featured',
						'new': 'home-products-new',
						'sale': 'home-products-sale',
						'promotion': 'home-products-promotion',
						'best_seller': 'home-products-best-seller',
						'main_product': 'home-product-main',
						'brands': 'home-brands',
						'testimonials': 'home-testimonials',
						'video': 'home-video',
						'institutional': 'home-institutional-message',
						'welcome': 'home-welcome-message',
						'instafeed': 'home-instagram-feed',
						'blog': 'home-blog-posts',
						'extra_menu': 'home-extra-menu',
						'newsletter': 'home-newsletter',
						'modules': 'home-image-text-module',
                    }
                }),
            };
		}
	};
})(jQueryNuvem);