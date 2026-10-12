/*============================================================================
style.css

    -This file contains all the theme non critical styles wich will be loaded asynchronously
    -Rest of styling can be found in:
      --static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
      --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/

/*============================================================================
  Table of Contents

  #Components
    // Margin and Padding
    // Mixins
    // Animations
    // Forms
    // Icons
    // Alerts and Notifications
    // Modals
    // Tables
    // Tabs
    // Cards
  #Header and nav
    // Nav
    // Search
  #Footer
    // Nav
    // Newsletter
  #Home page
    // Instafeed
    // Video
    // Banners
    // Empty screens placeholder
  #Product grid
    // Filters
    // Grid item
  #Product detail
    // Image
    // Form and info
  #Media queries
    // Min width 768px
      //// Components
      //// Footer
  #Critical path utilities

==============================================================================*/

/*============================================================================
  #Components
==============================================================================*/

{# /* // Margin and Padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%section-padding {
  padding-top: 30px;
  padding-bottom: 30px;
}
%element-margin {
  margin-bottom: 20px;
}
%element-margin-half {
  margin-bottom: 10px;
}

{# /* // Mixins */ #}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
  @each $prefix in $prefixes {
    #{'-' + $prefix + '-' + $property}: $value;
  }
  #{$property}: $value;
}


/* // Animations */

.transition-soft {
  transition: all 0.3s ease;
}

.transition-long {
  transition: all 0.6s ease;
}

.transition-opacity {
  transition: opacity 0.5s ease;
}

.delay-100 {
  transition-delay: 100ms;
}
.delay-200 {
  transition-delay: 200ms;
}

.transition-up {
  position: relative;
  top: -8px;
  transition: all 0.5s ease;
  z-index: 10;
  pointer-events: none;
}
.transition-up-active {
  top: 0;
  opacity: 1;
  z-index: 100;
  pointer-events: all;
}
.fade-in-vertical {
  transition: all 0.5s cubic-bezier(0.16, 0.68, 0.43, 0.99);
  transition-delay: 0.3s;
  transform: translate(0, 40%);
}
.fade-in-vertical.visible {
  transform: translate(0, 0%);
  opacity: 1;
}

.swing {
  @include prefix(animation-duration, 1s, webkit ms moz o);
  @include prefix(animation-fill-mode, both, webkit ms moz o);
  @include prefix(animation-iteration-count, 3, webkit ms moz o);   
  @include prefix(transform-origin, top center, webkit ms moz o);
  @include prefix(animation-name, swing, webkit ms moz o);
}

@-webkit-keyframes swing {
  20% {
    @include prefix(transform, rotate3d(0, 0, 1, 15deg), webkit ms moz o);
  }

  40% {
    @include prefix(transform, rotate3d(0, 0, 1, -10deg), webkit ms moz o);
  }

  60% {
    @include prefix(transform, rotate3d(0, 0, 1, 5deg), webkit ms moz o);
  }

  70% {
    @include prefix(transform, rotate3d(0, 0, 1, -5deg), webkit ms moz o);
  }

  80% {
    @include prefix(transform, rotate3d(0, 0, 1, 0deg), webkit ms moz o);
  }

  100% {
    @include prefix(transform, rotate3d(0, 0, 1, 0deg), webkit ms moz o);
  }
}

@keyframes swing {
  20% {
    @include prefix(transform, rotate3d(0, 0, 1, 15deg), webkit ms moz o);
  }

  40% {
    @include prefix(transform, rotate3d(0, 0, 1, -10deg), webkit ms moz o);
  }

  60% {
    @include prefix(transform, rotate3d(0, 0, 1, 5deg), webkit ms moz o);
  }

  70% {
    @include prefix(transform, rotate3d(0, 0, 1, -5deg), webkit ms moz o);
  }

  80% {
    @include prefix(transform, rotate3d(0, 0, 1, 0deg), webkit ms moz o);
  }

  100% {
    @include prefix(transform, rotate3d(0, 0, 1, 0deg), webkit ms moz o);
  }
}

@keyframes shake {
  10%, 90% {
    transform: translate3d(-1px, 0, 0);
  }
  
  20%, 80% {
    transform: translate3d(2px, 0, 0);
  }

  30%, 50%, 70% {
    transform: translate3d(-4px, 0, 0);
  }

  40%, 60% {
    transform: translate3d(4px, 0, 0);
  }
}

/* // Icons */

:root {
  --icon-alert: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M251.42,171.93c-8.18,.94-14.36,7.87-14.36,16.11s6.18,15.17,14.36,16.11c4.3,.06,8.44-1.64,11.46-4.7,3.02-3.06,4.66-7.22,4.55-11.52-.12-8.79-7.21-15.89-16.01-16.01Zm0,61.46c-4.26-.06-8.37,1.61-11.38,4.62-3.02,3.01-4.68,7.12-4.62,11.38v66.58c0,8.84,7.17,16.01,16.01,16.01s16.01-7.17,16.01-16.01v-66.16c.12-4.32-1.52-8.5-4.54-11.59-3.01-3.09-7.15-4.84-11.47-4.84Zm0-190.36c-115.34,.12-208.81,93.59-208.93,208.93,0,115.39,93.54,208.93,208.93,208.93s208.93-93.54,208.93-208.93c-.12-115.34-93.59-208.81-208.93-208.93Zm0,385.85c-97.71,0-176.92-79.21-176.92-176.92S153.71,75.04,251.42,75.04s176.92,79.21,176.92,176.92c-.12,97.66-79.26,176.8-176.92,176.92Z"/></svg>');
  --icon-alert-success: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 464c-118.664 0-216-96.055-216-216 0-118.663 96.055-216 216-216 118.664 0 216 96.055 216 216 0 118.663-96.055 216-216 216zm141.63-274.961L217.15 376.071c-4.705 4.667-12.303 4.637-16.97-.068l-85.878-86.572c-4.667-4.705-4.637-12.303.068-16.97l8.52-8.451c4.705-4.667 12.303-4.637 16.97.068l68.976 69.533 163.441-162.13c4.705-4.667 12.303-4.637 16.97.068l8.451 8.52c4.668 4.705 4.637 12.303-.068 16.97z"/></svg>');
  --icon-alert-warning: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path d="M174.61,108.76c14.66-27.38,43.21-44.44,74.27-44.39,31.6-.24,60.75,17.01,75.76,44.82l120.36,222.8c14.28,26.45,13.59,58.47-1.81,84.29-15.4,25.82-43.25,41.63-73.31,41.63H127.88c-30.15,0-58.07-15.89-73.45-41.83-15.38-25.94-15.93-58.06-1.46-84.51L174.61,108.76Zm121.22,15.58c-9.26-17.3-27.33-28.06-46.95-27.96-19.33,.13-37.07,10.76-46.31,27.74l-121.43,222.38c-9.07,16.49-8.74,36.55,.86,52.73,9.61,16.18,27.05,26.08,45.87,26.02h242.01c18.75-.11,36.08-10.03,45.68-26.13,9.6-16.11,10.08-36.06,1.27-52.61l-121-222.16Zm-46.95,196.13c-8.84,0-16.01,7.17-16.01,16.01s7.17,16.01,16.01,16.01c4.26,.06,8.37-1.61,11.38-4.62,3.01-3.02,4.68-7.12,4.62-11.38,0-4.23-1.69-8.27-4.7-11.24-3.01-2.97-7.08-4.61-11.31-4.55v-.21Zm0-29.24c-8.79-.12-15.89-7.21-16.01-16.01v-66.16c0-8.84,7.17-16.01,16.01-16.01s16.01,7.17,16.01,16.01v66.16c0,8.84-7.17,16.01-16.01,16.01Z"/></svg>');
  --icon-btn-spinner: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M460.115 373.846l-6.941-4.008c-5.546-3.202-7.564-10.177-4.661-15.886 32.971-64.838 31.167-142.731-5.415-205.954-36.504-63.356-103.118-103.876-175.8-107.701C260.952 39.963 256 34.676 256 28.321v-8.012c0-6.904 5.808-12.337 12.703-11.982 83.552 4.306 160.157 50.861 202.106 123.67 42.069 72.703 44.083 162.322 6.034 236.838-3.14 6.149-10.75 8.462-16.728 5.011z"/></svg>');
}

{# /* // Alerts and notifications */ #}

.alert {
  clear: both;
  margin-bottom: 15px;
  padding: 8px 10px;
  font-size: var(--font-base);
  border: var(--border-solid);
  border-radius: var(--border-radius-half);
  background: var(--main-background);
}
.alert-danger:before,
.alert-error:before,
.alert-info:before,
.alert-warning:before {
  display: inline-block;
  width: 20px;
  height: 20px;
  margin: 1px 5px 0 0;
  vertical-align: top;
  background-color: currentColor;
  content: '';
  mask-position: center;
  mask-repeat: no-repeat;
}
.alert-danger, 
.alert-error {
  color: var(--danger);
  border-color: var(--danger);
}
.alert-danger:before, 
.alert-error:before {
  -webkit-mask-image: var(--icon-alert);
  -ms-mask-image: var(--icon-alert);
  -moz-mask-image: var(--icon-alert);
  -o-mask-image: var(--icon-alert);
  mask-image: var(--icon-alert);
  background-color: var(--danger);
}
.alert-warning {
  color: var(--warning);
  border-color: var(--warning);
}
.alert-warning:before {
  -webkit-mask-image: var(--icon-alert-warning);
  -ms-mask-image: var(--icon-alert-warning);
  -moz-mask-image: var(--icon-alert-warning);
  -o-mask-image: var(--icon-alert-warning);
  mask-image: var(--icon-alert-warning);
}
.alert-info {
  color: var(--main-foreground);
  border-color: var(--main-foreground);
}
.alert-info:before {
  -webkit-mask-image: var(--icon-alert);
  -ms-mask-image: var(--icon-alert);
  -moz-mask-image: var(--icon-alert);
  -o-mask-image: var(--icon-alert);
  mask-image: var(--icon-alert);
}
.alert-success {
  color: var(--success);
  border-color: var(--success);
}
.alert-success:before {
  -webkit-mask-image: var(--icon-alert-success);
  -ms-mask-image: var(--icon-alert-success);
  -moz-mask-image: var(--icon-alert-success);
  -o-mask-image: var(--icon-alert-success);
  mask-image: var(--icon-alert-success);
}
.alert-primary {
  border-color: var(--accent-color);
  color: var(--accent-color);
}

.home-popup .alert {
  flex-direction: column;
  padding: 30px;
  &:before {
    margin: 0 0 5px;
  }
}

.modal-cart .alert {
  padding: 10px;
}

.notification-arrow-up {
  border-right: 10px solid transparent;
  border-bottom: 10px solid var(--main-background);
  border-left: 10px solid transparent;
}

.notification-danger {
  color: var(--danger);
}
.notification-hidden {
  transition: all 0.2s cubic-bezier(0.16, 0.68, 0.43, 0.99);
  transform: translate(0, -10%);
  opacity: 0;
  pointer-events: none;
}
.notification-visible {
  transition: all 0.2s cubic-bezier(0.16, 0.68, 0.43, 0.99);
  opacity: 1;
  transform: translate(0, 0);
}
.notification-cart-container {
  left: 15px;
  width: calc(100% - 30px);
}
.notification-cart-container .notification-cart {
  padding: 15px 30px 15px 15px;
}
.notification-img {
  width: 55px;
  height: 55px;
  overflow: hidden;
}
.notification-img svg {
  border-radius: 100%;
  background: var(--main-background);
}
.notification-close {
  position: absolute;
  top: 9px;
  right: 3px;
  z-index: 1;
  font-size: var(--font-smallest);
  cursor: pointer;
}

{# /* // Buttons */ #}

.btn-transition {
  position: relative;
  .transition-container {
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    opacity: 0;
    text-align: center;
    @include prefix(transition, all 0.5s ease, webkit ms moz o);
    pointer-events: none;
    cursor: not-allowed;
    transform: translateY(-50%);
    &.active {
      opacity: 1;
    }
  }
}

.js-item-quick-element {
  .js-addtocart {
    padding: 12px 0;
  }
}

{# /* // Forms */ #}

.form-group .form-label {
  float: left;
  width: 100%;
}

.price-filter-container .form-group {
  margin-bottom: 8px;
}

.form-quantity-icon {
  cursor: pointer;
}

.form-control-disabled {
  opacity: 0.3;
  pointer-events: none;
}

.variant-label {
  margin-bottom: 10px;
}

.list-readonly {
  .list-item{
    float: left;
    width: 100%;
    margin-bottom: 40px;
    &:only-child,
    &:last-of-type{
      margin-bottom: 0;
    }
    .radio-button-icons {
      display: none;
    }
    .radio-button {
      cursor: default;
    }
    .radio-button-content{
      margin: 0 !important;
      padding: 0;
      border: 0;
    }
  }

  .radio-button,
  .shipping-extra-options .radio-button-item:first-child .radio-button{
    margin: 0;
  }
  .radio-button-label{
    padding-left: 0;
  }
  .shipping-extra-options .list-item:first-child{
    margin-top: 40px;
  }
}

.checkbox-container{
  .checkbox {
    position: relative;
    display: block;
    margin-bottom: 15px;
    padding-left: 30px;
    font-weight: normal;
    text-decoration: none;
    @include prefix(transition, all 0.4s ease, webkit ms moz o);
    cursor: pointer;
    &-icon {
      position: absolute;
      left: 0;
      display: block;
      width: 20px;
      height: 20px;
      border-radius: 3px;
      &:after {
        position: absolute;
        top: 2px;
        left: 6px;
        display: none;
        width: 6px;
        height: 12px;
        content: '';
        @include prefix(transform, rotate(45deg), webkit ms moz o);
      }
    }
    &-text {
      display: inline-block;
      padding-top: 3px;
      &.with-color {
        padding-right: 30px;
      }
    }
    &-color {
      position: absolute;
      right: 0;
      display: inline-block;
      width: 18px;
      height: 18px;
      border-radius: 50%;
    }
  }
  input {
    display: none;
    &:checked ~ .checkbox {
      opacity: 1;
      .checkbox-icon:after {
        display: block;
      }
    }
  }
}

.form-select {
  display: block;
  width: 100%;
  &:focus{
    outline:0;
  }
  &::-ms-expand {
    display: none;
  }
}

.form-select-options {
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 200;
  width: 100%;
  max-height: 200px;
  margin-top: 5px;
  padding: 0;
  list-style: none;
  overflow-y: auto;
  opacity: 0;
  background-color: var(--main-background);
  -webkit-transition: all 0.2s ease;
  -moz-transition: all 0.2s ease;
  -ms-transition: all 0.2s ease;
  -o-transition: all 0.2s ease;
  transition: all 0.2s ease;
}

.form-select-options.open {
  opacity: 1;
}

.form-select-options::-webkit-scrollbar {
  width: 7px;
}
.form-select-options::-webkit-scrollbar-track {
  background: var(--main-background-opacity-50);
  border-radius: 6px;
}

.form-select-options::-webkit-scrollbar-thumb {
  background: var(--main-foreground-opacity-50);
  border-radius: 6px;
}

.form-select-option {
  padding: 8px 12px;
  font-size: var(--font-small);
  -webkit-transition: all 0.4s ease;
  -moz-transition: all 0.4s ease;
  -ms-transition: all 0.4s ease;
  -o-transition: all 0.4s ease;
  transition: all 0.4s ease;
  cursor: pointer;
}

.form-select-option:hover,
.form-select-option:active {
  background-color: var(--main-foreground-opacity-08);
}

.form-select-option.selected {
  background-color: var(--main-foreground-opacity-05);
}

.btn-whatsapp {
  animation-name: shake;
  animation-delay: 0;
  animation-iteration-count: infinite;
  animation-direction: forward;
}

/* Disabled controls */

input[disabled], 
select[disabled], 
textarea[disabled], 
button[disabled], 
input[disabled]:hover, 
select[disabled]:hover, 
textarea[disabled]:hover, 
button[disabled]:hover, 
input[readonly], 
select[readonly], 
textarea[readonly], 
button[readonly], 
input[readonly]:hover, 
select[readonly]:hover, 
textarea[readonly]:hover, 
button[readonly]:hover {
  background-color: #ddd;
  cursor: not-allowed;
}
.list .radio-button-icons-container {
  display: none;
}
.list .radio-button-label {
  padding: 0;
}

{# /* // Alerts and notifications */ #}

.alert {
  clear: both;
  margin-bottom: 15px;
  padding: 15px;
  text-align: center;
}

.item-actions .alert {
  position: absolute;
  width: calc(100% - 20px);
  left: 10px;
  bottom: 0;
  margin-bottom: 0;
  z-index: 200;
}

.home-popup .alert {
  position: absolute;
  left: 0;
  bottom: 0;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  margin-bottom: 0;
  z-index: 1;
}

{# /* // Progress bar */ #}

.progress-bar {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.progress-bar-title-container {
  display: flex;
  align-items: center;
  gap: 8px;
}

.progress-bar-title {
  flex: 1;
  min-width: 0;
  font-weight: bold;
  color: var(--accent-color);
}

.progress-bar-icon {
  flex-shrink: 0;
  font-size: 20px;
  fill: var(--accent-color);
}

.progress-bar-subtitle {
  font-size: var(--font-medium);
  color: var(--main-foreground-opacity-60);
}

.progress-bar-subtitle:not(:has(> :not([style*="display: none"]))) {
  display: none;
}

.gift-promotion-progress {
  margin-top: 8px;
  margin-bottom: 16px;
  padding-bottom: 4px;
}

.bar-progress {
  position: relative;
  height: 4px;
  margin-top: 2px;
}

.bar-progress-active {
  width: 0%;
  height: 4px;
}

.bar-progress-check {
  position: absolute;
  top: -8px;
  right: 0;
  width: 20px;
  height: 20px;
  font-size: 16px;
  text-align: center;
  transform: scale(0.5);
  opacity: 0;
  transition: transform 200ms ease, opacity 200ms ease;
}

.bar-progress-check.active {
  transform: scale(1);
  opacity: 1;
}

.ship-free-rest-message .ship-free-rest-text {
  display: none;
}

.ship-free-rest-message.success .bar-progress-success,
.ship-free-rest-message.amount .bar-progress-amount,
.ship-free-rest-message.condition .bar-progress-condition {
  display: block;
}


{# /* // Modals */ #}

.modal-overlay-search {
  background: none;
}

.modal-search-form {
  position: absolute;
  width: calc(100% - 30px);
  max-width: 45rem;
  top: 35%;
  left: 50%;
  transform: translate(-50%, -35%);
}

.home-popup .modal-close {
  position: absolute;
  right: 0;
  z-index: 1;
}

.modal-full-width {
  width: 100%;
  max-width: 100%;
}
.modal-body-scrollable-auto .modal-body {
  max-height: calc(100vh - 100px);
  overflow-y: auto;
}

{# /* // Tabs */ #}

.tab-group{
  width: 100%;
  padding: 0;
  overflow-x: scroll;
  white-space: nowrap;
  .tab{
    display: inline-flex;
    float: none;
    &-link{
      float: left;
      padding: 10px;
      text-align: center;
    }
  }
}

.tab-panel:not(.active){
  display: none;
}
.tab-panel.active{
  display: block;
}

/* // Cards */

.card {
  position: relative;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-direction: column;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-clip: border-box;
}
.card-collapse {
  height: 55px;
  padding: 0;
  overflow: hidden;
  transition: all 0.3s ease;
  cursor: pointer;
}
.card-collapse-toggle {
  position: absolute;
  top: 7px;
  right: 8px;
  padding: 10px;
  transition: all 0.3s ease;
}
.card-collapse.active {
  height: 100%;
}
.card-body {
  -ms-flex: 1 1 auto;
  flex: 1 1 auto;
  padding: 15px;
}
.card-header {
  padding: 16px 15px;
  margin-bottom: 0;
}
.card-header-collapse {
  padding-right: 50px;
  position: relative;
}
.card-footer {
  padding: 15px;
}

/*============================================================================
  #Header and nav
==============================================================================*/
{# /* // Header */ #}

{# /* // Nav */ #}

.nav-item.with-icon {
  .category-icon {
    filter: invert(1);
    max-height: 36px !important;
    height: auto;
    width: 24px;
  }
}

.nav-menu-full .desktop-dropdown::-webkit-scrollbar {
  width: 5px;
}

.nav-menu-full .desktop-dropdown {
  position: absolute;
  display: flex;
  justify-content: space-between;
  padding: 20px 40px;
  overflow-y: auto;
  top: inherit;
}

.desktop-dropdown::-webkit-scrollbar-track {
  background: var(--main-foreground-opacity-50);
}
.desktop-dropdown::-webkit-scrollbar-thumb {
  background: var(--main-foreground-opacity-40);
}
.desktop-dropdown::-webkit-scrollbar-thumb:hover {
  background: var(--main-foreground);
}

.nav-menu-box .nav-desktop-list > .item-with-subitems:last-of-type .desktop-list-subitems,
.nav-menu-box .desktop-list-subitems {
  padding: 5px 0;
  .nav-item {
    display: block;
    margin: 0;
    padding: 0;
    -webkit-column-break-inside: avoid;
    break-inside: avoid;
    position: relative;
    &:before {
      content:"";
      position: absolute;
      bottom: 0;
      left: 10px;
      width: calc(100% - 20px);
      height: 1px;
    }
    &:last-child {
      &:before {
        display:none;
      }
    }
    .nav-list-link {
      width: 100%;
      text-align: left;
      line-height: 1.2;
      padding: 10px 15px;
    }
    &:hover {
      &>.list-subitems {
        opacity: 1;
        display: block;
        visibility: visible;
      }
    }
    .list-subitems {
      opacity: 0;
      position: absolute;
      visibility: hidden;
      left: 100%;
      top: 0;
      padding: 0;
      min-width: 200px;
      z-index: 1;
      .nav-list-link {
        padding: 10px 15px;
      }
      & .list-subitems {
        display:none;
        opacity: 0;
        a {
          transition: 0s;
        }
      }
      & .nav-item:hover {
        .list-subitems {
          display: block;
          opacity: 1;
          a {
            transition: 0s;
          }
        }
      }
    }
  }
  .nav-list-link {
    display: block;
    padding: 5px 10px;
    line-height: 20px;
    font-size: var(--font-base);
  }
}

.nav-menu-full .desktop-list-subitems {
  width: 100%;
  padding: 0;
  text-align: left;
  -webkit-column-count: 6;  
  -webkit-column-gap: 20px;   
  -moz-column-count: 6;   
  -moz-column-gap: 20px;
  column-count: 6;  
  column-gap: 20px;  
  .nav-item {
    display: block;
    margin: 0;
    padding: 0;
    -webkit-column-break-inside: avoid;
    break-inside: avoid;
    .nav-list-link {
      margin-bottom: 10px;
      font-size: var(--font-base);
      text-transform: initial;
      font-weight: bold;
    }
    .list-subitems {
      padding: 0;
      margin: 0 0 30px 0;
      .nav-item {
        .nav-list-link {
          font-weight: normal;
          text-transform: none;
        }
        .list-subitems {
          margin: 0 0 0 8px;
          .nav-list-link {
            padding: 0px 0 0 10px;
            line-height: 15px;
            font-size: var(--font-small);
          }
        }
      }
    }
  }
  .nav-list-link {
    display: block;
    margin-bottom: 10px;
    line-height: 20px;
  }
}

.nav-menu-box .desktop-dropdown.open-right {
  .desktop-list-subitems {
    .nav-item {
      .list-subitems {
        left: 100%;
        right: inherit;
      }
      .nav-list-arrow {
        left: inherit;
        right: 10px;
      }
    }
  }
}

.nav-menu-box .desktop-dropdown.open-left {
  .desktop-list-subitems {
    .nav-item.item-with-subitems {
      & > .nav-item-container > .nav-list-link {
        padding-left: 32px;
      }
      .list-subitems {
        left: inherit;
        right: 100%;
      }
      .nav-list-arrow {
        left: 10px;
        right: inherit;
      }
    }
  }
}

.nav-desktop .desktop-list-subitems a {
  color: var(--main-foreground);
  font-weight: var(--font-weight-regular) !important;
}

.nav-desktop {
  .nav-list-link:hover {
    opacity: 1;
  }
}

.nav-menu-full,
.nav-menu-full .nav-desktop-list {
  position: unset;
}

.nav-menu-full .desktop-dropdown {
  left: 50%;
  transform: translateX(-50%);
}

.nav-desktop-list-arrow{
  position: absolute;
  height: 100%;
  width: 30px;
  text-align: center;
  line-height: 54px;
  font-size: 10px;
  cursor: pointer;
  z-index: 3;
  &-left {
    left: 0;
  }
  &-right {
    right: 0;
  }
  &.disable{
    opacity: 0.2;
    cursor: initial; 
  }
}

.nav-dropdown-content:hover,
.nav-dropdown:hover .nav-dropdown-content,
.nav-desktop-list:hover .nav-main-item.selected .nav-dropdown-content {
  visibility: visible;
  opacity: 1;
  transition-delay: 0s;
}

.nav-item-desktop:hover .navigation-banner {
  display: block;
}

.menu-overlay{
  visibility: hidden;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #00000047;
  z-index: 99;
  opacity: 0;
  transition: opacity .4s, visibility 0s .4s;
  &.active{
    visibility: visible;
    opacity: 1;
    transition: opacity 1s;
  }
}

.nav-dropdown:hover .nav-dropdown-content {
  visibility: visible;
  opacity: 1;
  pointer-events: auto;
  transition-delay: 0s;
}

.header-style5 .navigation-col,
.nav-desktop.head-style5.nav-menu-full {
  position: unset;
}
.nav-desktop.head-style5.nav-menu-full .item-with-subitems:not(.departments) .desktop-dropdown {
    left: 50%;
    transform: translateX(-50%);
}
.nav-menu-full .nav-desktop-list > .item-with-subitems:last-of-type > .desktop-dropdown {
    left: 50%;
    right: inherit;
}

{# /* // Utilities */ #}

.subutility-list {
  position: absolute;
  width: max-content;
  top: 100%;
  left: 50%;
  padding: 10px;
  margin: 0;
  list-style: none;
  transform: translateX(-50%);
  -webkit-transform: translateX(-50%);
  -ms-transform: translateX(-50%);
  text-align: left;
  z-index: 10000;
}

.subutility-list-item {
  &:first-child a {
    border-bottom: 1px solid #eee;
  }  
  a {
    display: block;
    padding: 8px 5px;
    text-align: center;
  }
}

.js-utilities-item.nav-account.active > .subutility-list {
  display: block;
}

{# /* // Search */ #}

.search-input[type="search"]::-webkit-search-cancel-button {
  -webkit-appearance:none;
}

.search-suggestions {
  position: absolute;
  z-index: 99999;
  width: calc(100% - 30px);
  min-width: 280px;
  max-height: calc(100vh - 180px);
  overflow-y: auto;
  overflow-x: hidden;
  border-radius: 3px;
  box-shadow: 0 10px 15px rgba(#000,.2);
}

.search-suggestions-image-container, .search-suggestions .col-auto {
	padding: 0;
}

.search-suggestions-image {
	max-width: 50px;
}

.search-suggestions-text {
	line-height: initial;
}

.search-suggestions-text p {
	font-size: 13px;
	line-height: initial !important;
}

.search-suggestions-item {
	border-bottom: 1px solid rgba(0, 0, 0, .1);
}

.search-suggestions .icon-flip-horizontal {
	transform: none !important;
}

/* // Search */

.search-form .search-empty-btn {
  margin: -17px 2px 0 0;
}
.search-form .search-empty-btn:before {
  width: 18px;
  height: 18px;
}

.modal-nav-search .search-form {
  position: fixed;
  z-index: 1;
  width: calc(100% - 30px);
  font-size: var(--font-base);
  margin: 50px 15px;
}

.modal-nav-search .search-form.search-form-ios {
  height: 60px;
}
.modal-nav-search .search-input {
  padding: 20px 60px 20px 20px;
  background-color: var(--main-foreground-opacity-03);
}
.modal-nav-search .search-form .search-empty-btn {
  width: 25px;
  height: 25px;
  padding: 7px;
  margin: -14px 12px 0 0;
  border-radius: 100%;
  background-color: var(--main-background);
}
.modal-nav-search .search-form .search-empty-btn:before {
  width: 12px;
  height: 12px;
}
.modal-nav-search .search-suggestions {
  z-index: 0;
  margin-top: 120px;
  width: calc(100% - 30px);
  left: 15px;
  max-height: initial;
}
.search-input[type="search"]::-webkit-search-cancel-button {
  -webkit-appearance: none;
}
.search-suggestions {
  position: absolute;
  z-index: 99999;
  width: 100%;
  max-height: calc(100vh - 250px);
  overflow-y: auto;
  overflow-x: hidden;
  background-color: var(--main-background);
  border: var(--border-solid) var(--main-foreground-opacity-10);
}
.search-suggestions a {
  color: var(--main-foreground);
  fill: var(--main-foreground);
}
.search-suggestions .search-suggestions-list {
  margin: 0;
  padding: 0;
}
.search-suggestions .search-suggestions-text {
  flex-basis: 0;
  flex-grow: 1;
  max-width: 100%;
  padding: 0 25px 0 5px;
  font-size: var(--font-base);
}
.search-suggestions .search-suggestions-item {
  padding: 0;
  text-align: left;
  list-style: none;
  border-bottom: var(--border-solid) var(--main-foreground-opacity-08);
}
.search-suggestions .search-suggestions-item .search-suggestions-link {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  margin: 0;
}
.search-suggestions .search-suggestions-item .search-suggestions-text, 
.search-suggestions .search-suggestions-item .search-suggestions-name {
  margin-bottom: 2px;
  line-height: 18px;
}
.search-suggestions .search-suggestions-item .search-suggestions-price {
  font-weight: bold;
}
.search-suggestions .search-suggestions-image-container {
  position: relative;
  flex: 0 0 auto;
  width: 80px;
  height: 80px;
  overflow: hidden;
}
.search-suggestions .search-suggestions-image-container img {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 100%;
  height: 100%;
  padding: 15px;
  transform: translate(-50%, -50%);
  object-fit: cover;
}
.search-suggestions .search-suggestions-all-link-container {
  margin: 15px 0;
  text-align: center;
}
.search-suggestions .search-suggestions-all-link {
  font-size: var(--font-small);
}
.head-main .search-suggestions {
  width: calc(100% - 30px);
}

.nav-hamburger .search-suggestions {
  max-width: calc(100% - 30px);
}

/*============================================================================
  #Footer
==============================================================================*/
{% if settings.footer_background and 'footer_background.jpg' | has_custom_image %}
  @media (min-width: 768px) {
    .footer-background {
      background-image: url('{{ 'footer_background.jpg' | static_url | settings_image_url('1080p') }}');
      background-size: var(--footer-background-size);
      background-position: center;
      background-repeat: var(--footer-background-repeat);
    }
    .footer-background > .footer-form {
      background: none;
    }
  }
{% endif %}

{% if settings.footer_background_mobile and 'footer_background_mobile.jpg' | has_custom_image %}
  @media (max-width: 767px) {
    .footer-background {
      background-image: url('{{ 'footer_background_mobile.jpg' | static_url | settings_image_url('480w') }}');
      background-size: var(--footer-background-size-mobile);
      background-position: center;
      background-repeat: var(--footer-background-repeat-mobile);
    }
    .footer-background > .footer-form {
      background: none;
    }
  }
{% endif %}

footer.news-top {
  padding-top: 0;
}

.element-footer-line {
  padding-top: 2.5em;
}

footer.main-footer {
  @media (max-width: 767px) {
    text-align: center;
  }
}

.footer-form, .footer-payments-shipping-logos,
.footer-legal {
  padding: 25px 0;
}

.footer-menus {
  padding-top: 40px;
}

p.footer-about {
  font-size: 14px;
  margin-bottom: 0;
}

{# /* // Nav */ #}

.footer-menu {
  list-style: none;
  &-item{
    display: block;
    margin-bottom: 10px;
  }
  &-link{
    display: block;
  }
}

.footer-menu.multi-col {
  -moz-column-count: 2;
  -moz-column-gap: 20px;
  -webkit-column-count: 2;
  -webkit-column-gap: 20px;
  column-count: 2;
  column-gap: 20px;
}

{# /* // Newsletter */ #}

.footer-payments-shipping-logos .footer-payments img,
.footer-payments-shipping-logos .footer-shipping img {
  max-height: 28px;
  margin: 2px;
  border: 1px solid rgba(#000,.1);
  border-radius: 3px;
}

.footer-payments-shipping-logos .footer-payments svg,
.footer-payments-shipping-logos .footer-shipping svg {
  width: 54px;
  height: 28px;
  margin: 2px;
  padding: 2px 10px;
  border: 1px solid #ddd;
  border-radius: 3px;
  vertical-align: 0;
}

.security-logos img {
  max-height: 60px;
  border: none;
}

.powered-by-logo {
  display: inline-block;
  height: 20px;
}

.powered-by-logo a svg {
  height: 17px;
}

.powered-by-logo a[href*="next"] svg {
  height: 22px;
}

.footer-logo img {
  max-height: 50px;
  margin: 2px;
}

.credits-logo a {
  display: inline-flex;
  align-items: center;
}

.credits-logo img {
  height: 17px;
  width: auto;
  margin-left: 10px;
}
   
/*============================================================================
  #Home Page
==============================================================================*/

.section-home-module {
  .title-line {
    font-size: 34px;
  }
}

.section-informative-banners {
  .swiper-pagination-bullets {
    bottom: 5px;
  }
}

{% if settings.slider_banner %}
  .section-slider .swiper-slide img {
    width: auto;
  }

  @media (min-width: 1199px) {
    .section-slider .swiper-slide {
      height: 428px;
    }
    .banner-slider {
      height: 428px;
    }
  }

  @media (min-width: 991px) and (max-width: 1199px) {
    .section-slider .swiper-slide {
      height: 360px;
    }
    .banner-slider {
      height: 360px;
    }
  }

  @media (max-width: 990px) and (min-width: 768px) {
    .section-slider .swiper-slide {
      height: 243px;
    }
    .banner-slider {
      height: 243px;
    }
  }
{% else %}
  .section-slider .swiper-slide {
    width: 100%;
  }
{% endif %}

{# /* // Instafeed */ #}

{% set instafeed_gutters = settings.instafeed_gutters %}

{% if instafeed_gutters == 1 %}
  $instafeed-gutters: 2px;
{% elseif instafeed_gutters == 2 %}
  $instafeed-gutters: 6px;
{% elseif instafeed_gutters == 3 %}
  $instafeed-gutters: 15px;
{% else %}
  $instafeed-gutters: 0;
{% endif %}

.instafeed-col {
  padding: $instafeed-gutters !important;
}

.instafeed-link {
  position: relative;
  display: block;
  overflow: hidden;
  padding-top: 100%;
  .instafeed-info {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding: 0;
    text-align: center;
    opacity: 0;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
    .instafeed-info-item {
      display: inline-block;
      margin-top: 38%;
    }
  }
  &:hover,
  &:focus {
    .instafeed-img {
      width: 110%;
    }
    .instafeed-info {
      opacity: 1;
    }
  }
}

.instafeed-intro {
  height: 100%;
}

.instafeed-img {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  height: auto;
  @include prefix(transition, all 0.3s ease, webkit ms moz o);
}

.social-home-title.instafeed-title {
  font-size: 2em;
}

{# /* // Video */ #}

.user-content iframe {
  width: 700px !important;
  height: 380px !important;
}
@media screen and (max-width: 640px)
{
.user-content iframe {
  width: 520px !important;
  height: 280px !important;
  }
}

@media screen and (max-width: 480px)
{
.user-content iframe {
  width: 420px !important;
  height: 240px !important;
  }
}
@media screen and (max-width: 360px)
{
.user-content iframe {
  width: 320px !important;
  height: 180px !important;
  }
}

{# /* // Banners */ #}

.gridbanners {
  .gridbanner-image {
    transition: all 0.5s ease;
  }
  a:hover .gridbanner-image,
  a:focus .gridbanner-image {
    transform: scale(1.03);
  }
}

{# /* // Brands */ #}

.brands-slider {
  position: relative;

  .swiper-wrapper {
    line-height: 100px;
  }

  .swiper-button-disabled {
    opacity: 0.4;
    visibility: visible;
  }
}

.brand-image {
  display: inline-block;
  max-width: 100%;
  {% if settings.logos_height matches '/^\\d+$/' %}
  max-height: {{ settings.logos_height }}px;
  {% else %}
  max-height: 100px;
  {% endif %}
  vertical-align: middle;
  transform: scale(0.92);
  @include prefix(transition, all 0.8s ease, webkit ms moz o);
  &:hover {
    transform: scale(1.05);
  }
}

{# /* // Empty screens placeholder */ #}

.placeholder-overlay {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 9;
  width: 100%;
  height: 100%;  
}

.placeholder-info {
  position: relative;
  top: 50%;
  left: 50%;
  width: 300px;
  padding: 30px 25px;
  text-align: center;
  line-height: 18px;
  transform: translate(-50%, -50%);
  box-sizing: border-box;
  .placeholder-description {
    margin: 20px 0;
  }
  .placeholder-button {
    padding: 8px 15px;
  }
}

/*============================================================================
  #Product Grid
==============================================================================*/

{# /* // Filters */ #}

.filters-overlay {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 30000;
  width: 100%;
  height: 100%;
  .filters-updating-message {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 80%;
    text-align: center;
    @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
  }
}

{# /* // Grid item */ #}

.animation-container {
  margin-top: -20px;
}

.animation-container .swiper-wrapper {
  padding-top: 20px;
}

.item-image:hover img {
  transform: translateX(-50%) scale(1.04) !important;
}

.item.item-animation {
  transition: all .3s ease-in-out;
}
.item.item-animation:hover {
  @media (min-width: 767px) {
    margin-top: -5px;
    margin-bottom: 30px;
    transition: all .3s ease-in-out;
  }
}

{# Sizes #}

.quickshop-direct-btn + .alert {
  margin: 30px 0 -20px 0;
}

/* Quickshop modal */

.quickshop-grid {
  display: grid;
  grid-template-columns: 35% auto;
  grid-template-rows: auto auto;
  padding: 15px;
  gap: 15px;
  grid-template-areas:
    "image price"
    "form form";
}

@media (min-width: 768px) {
  .quickshop-grid {
    padding: 0;
    grid-template-columns: 1fr 1fr;
    grid-template-areas:
      "image price"
      "image form";
  }
}

.quickshop-image {
  position: absolute;
  width: auto;
  height: auto;
}

.quickshop-item-variants {
  grid-area: price;
}

@media (min-width: 768px) {
  .quickshop-item-variants {
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
  }
}

.quickshop-form {
  grid-area: form;
}

.quickshop-item-name {
  font-size: 1.25rem;
}

.quickshop-image-container {
  grid-area: image;
  position: relative;
  overflow: hidden;
}

.quickshop-image-container > * {
  position: relative;
  overflow: hidden;
  border-radius: 6px;
}

.modal-quickshop .quickshop-item-variants .modal-close {
  position: absolute;
  right: 0;
  top: 0;
  padding: 8px;
}

.modal-quickshop .product-price {
  font-size: var(--font-20);
}

.modal-quickshop .price-compare {
  font-size: var(--font-16);
}

.modal-quickshop .btn-add-to-cart {
  font-size: var(--font-base);
  line-height: 18px;
}

/*============================================================================
  #Product detail
==============================================================================*/

{# /* // Image */ #}

.fancybox__container .has-inline .fancybox__content {
  width: 100%;
  height: calc(100% - 20px);
  padding: 0;
  transform: translateY(20px);
  background: transparent;
}

.fancybox__container .has-inline .fancybox__content .fancybox-close-small {
  /* Hardcoded neutral color to match non iframe fancybox modal */
  color: #ccc !important;
}

.fancybox__container .fancybox__slide.has-inline::before {
  display: none
}

.fancybox-toolbar {
  opacity: 1 !important;
  visibility: visible !important;
}
.fancybox-toolbar .fancybox-button {
  display: none !important;
}
.fancybox-toolbar .fancybox-button.fancybox-button--close {
  display: block !important;
}
.fancybox-close-small {
  display: none !important;
}

{% if settings.custom_page_show %}
  {# /* // Custom page */ #}

  .section-custom {
    padding: 3em 0;
  }

  .section-custom .row {
    gap: 2em;
  }

  @media (min-width: 768px) {
    .section-custom .row {
      gap: 2em;
    }
    .section-custom:nth-child(even) .section-image {
      order: 2;
    }
  }

  .custom-section-1 {
    background-color: var(--custom-section-1-background);
    color: var(--custom-section-1-foreground);
  }
  .custom-section-1 .custom-section-link {
    background: var(--custom-section-1-button-background);
    color: var(--custom-section-1-button-foreground);
  }

  .custom-section-2 {
    background-color: var(--custom-section-2-background);
    color: var(--custom-section-2-foreground);
  }
  .custom-section-2 .custom-section-link {
    background: var(--custom-section-2-button-background);
    color: var(--custom-section-2-button-foreground);
  }

  .custom-section-3 {
    background-color: var(--custom-section-3-background);
    color: var(--custom-section-3-foreground);
  }
  .custom-section-3 .custom-section-link {
    background: var(--custom-section-3-button-background);
    color: var(--custom-section-3-button-foreground);
  }

  .custom-section-4 {
    background-color: var(--custom-section-4-background);
    color: var(--custom-section-4-foreground);
  }
  .custom-section-4 .custom-section-link {
    background: var(--custom-section-4-button-background);
    color: var(--custom-section-4-button-foreground);
  }

  .custom-section-5 {
    background-color: var(--custom-section-5-background);
    color: var(--custom-section-5-foreground);
  }
  .custom-section-5 .custom-section-link {
    background: var(--custom-section-5-button-background);
    color: var(--custom-section-5-button-foreground);
  }

  .custom-section-link:hover {
    opacity: .8;
  }

{% endif %}

.carousel{position:relative;box-sizing:border-box}.carousel *,.carousel *:before,.carousel *:after{box-sizing:inherit}.carousel.is-draggable{cursor:move;cursor:grab}.carousel.is-dragging{cursor:move;cursor:grabbing}.carousel__viewport{position:relative;overflow:hidden;max-width:100%;max-height:100%}.carousel__track{display:flex}.carousel__slide{flex:0 0 auto;width:var(--carousel-slide-width, 60%);max-width:100%;padding:1rem;position:relative;overflow-x:hidden;overflow-y:auto;overscroll-behavior:contain}.has-dots{margin-bottom:calc(0.5rem + 22px)}.carousel__dots{margin:0 auto;padding:0;position:absolute;top:calc(100% + 0.5rem);left:0;right:0;display:flex;justify-content:center;list-style:none;user-select:none}.carousel__dots .carousel__dot{margin:0;padding:0;display:block;position:relative;width:22px;height:22px;cursor:pointer}.carousel__dots .carousel__dot:after{content:"";width:8px;height:8px;border-radius:50%;position:absolute;top:50%;left:50%;transform:translate(-50%, -50%);background-color:currentColor;opacity:.25;transition:opacity .15s ease-in-out}.carousel__dots .carousel__dot.is-selected:after{opacity:1}.carousel__button{width:var(--carousel-button-width, 48px);height:var(--carousel-button-height, 48px);padding:0;border:0;display:flex;justify-content:center;align-items:center;pointer-events:all;cursor:pointer;color:var(--carousel-button-color, currentColor);background:var(--carousel-button-bg, transparent);border-radius:var(--carousel-button-border-radius, 50%);box-shadow:var(--carousel-button-shadow, none);transition:opacity .15s ease}.carousel__button.is-prev,.carousel__button.is-next{position:absolute;top:50%;transform:translateY(-50%)}.carousel__button.is-prev{left:10px}.carousel__button.is-next{right:10px}.carousel__button[disabled]{cursor:default;opacity:.3}.carousel__button svg{width:var(--carousel-button-svg-width, 50%);height:var(--carousel-button-svg-height, 50%);fill:none;stroke:currentColor;stroke-width:var(--carousel-button-svg-stroke-width, 1.5);stroke-linejoin:bevel;stroke-linecap:round;filter:var(--carousel-button-svg-filter, none);pointer-events:none}html.with-fancybox{scroll-behavior:auto}body.compensate-for-scrollbar{overflow:hidden !important;touch-action:none}.fancybox__container{position:fixed;top:0;left:0;bottom:0;right:0;direction:ltr;margin:0;padding:env(safe-area-inset-top, 0px) env(safe-area-inset-right, 0px) env(safe-area-inset-bottom, 0px) env(safe-area-inset-left, 0px);box-sizing:border-box;display:flex;flex-direction:column;color:var(--fancybox-color, #fff);-webkit-tap-highlight-color:rgba(0,0,0,0);overflow:hidden;z-index:1050;outline:none;transform-origin:top left;--carousel-button-width: 48px;--carousel-button-height: 48px;--carousel-button-svg-width: 24px;--carousel-button-svg-height: 24px;--carousel-button-svg-stroke-width: 2.5;--carousel-button-svg-filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.4))}.fancybox__container *,.fancybox__container *::before,.fancybox__container *::after{box-sizing:inherit}.fancybox__container :focus{outline:none}body:not(.is-using-mouse) .fancybox__container :focus{box-shadow:0 0 0 1px #fff,0 0 0 2px var(--fancybox-accent-color, rgba(1, 210, 232, 0.94))}@media all and (min-width: 1024px){.fancybox__container{--carousel-button-width:48px;--carousel-button-height:48px;--carousel-button-svg-width:27px;--carousel-button-svg-height:27px}}.fancybox__backdrop{position:absolute;top:0;right:0;bottom:0;left:0;z-index:-1;background:var(--fancybox-bg, rgba(24, 24, 27, 0.92))}.fancybox__carousel{position:relative;flex:1 1 auto;min-height:0;height:100%;z-index:10}.fancybox__carousel.has-dots{margin-bottom:calc(0.5rem + 22px)}.fancybox__viewport{position:relative;width:100%;height:100%;overflow:visible;cursor:default}.fancybox__track{display:flex;height:100%}.fancybox__slide{flex:0 0 auto;width:100%;max-width:100%;margin:0;padding:48px 8px 8px 8px;position:relative;overscroll-behavior:contain;display:flex;flex-direction:column;outline:0;overflow:auto;--carousel-button-width: 36px;--carousel-button-height: 36px;--carousel-button-svg-width: 22px;--carousel-button-svg-height: 22px}.fancybox__slide::before,.fancybox__slide::after{content:"";flex:0 0 0;margin:auto}@media all and (min-width: 1024px){.fancybox__slide{padding:64px 100px}}.fancybox__content{margin:0 env(safe-area-inset-right, 0px) 0 env(safe-area-inset-left, 0px);padding:36px;color:var(--fancybox-content-color, #374151);background:var(--fancybox-content-bg, #fff);position:relative;align-self:center;display:flex;flex-direction:column;z-index:20}.fancybox__content :focus:not(.carousel__button.is-close){outline:thin dotted;box-shadow:none}.fancybox__caption{align-self:center;max-width:100%;margin:0;padding:1rem 0 0 0;line-height:1.375;color:var(--fancybox-color, currentColor);visibility:visible;cursor:auto;flex-shrink:0;overflow-wrap:anywhere}.is-loading .fancybox__caption{visibility:hidden}.fancybox__container>.carousel__dots{top:100%;color:var(--fancybox-color, #fff)}.fancybox__nav .carousel__button{z-index:40}.fancybox__nav .carousel__button.is-next{right:8px}@media all and (min-width: 1024px){.fancybox__nav .carousel__button.is-next{right:40px}}.fancybox__nav .carousel__button.is-prev{left:8px}@media all and (min-width: 1024px){.fancybox__nav .carousel__button.is-prev{left:40px}}.carousel__button.is-close{position:absolute;top:8px;right:8px;top:calc(env(safe-area-inset-top, 0px) + 8px);right:calc(env(safe-area-inset-right, 0px) + 8px);z-index:40}@media all and (min-width: 1024px){.carousel__button.is-close{right:40px}}.fancybox__content>.carousel__button.is-close{position:absolute;top:-40px;right:0;color:var(--fancybox-color, #fff)}.fancybox__no-click,.fancybox__no-click button{pointer-events:none}.fancybox__spinner{position:absolute;top:50%;left:50%;transform:translate(-50%, -50%);width:50px;height:50px;color:var(--fancybox-color, currentColor)}.fancybox__slide .fancybox__spinner{cursor:pointer;z-index:1053}.fancybox__spinner svg{animation:fancybox-rotate 2s linear infinite;transform-origin:center center;position:absolute;top:0;right:0;bottom:0;left:0;margin:auto;width:100%;height:100%}.fancybox__spinner svg circle{fill:none;stroke-width:2.75;stroke-miterlimit:10;stroke-dasharray:1,200;stroke-dashoffset:0;animation:fancybox-dash 1.5s ease-in-out infinite;stroke-linecap:round;stroke:currentColor}@keyframes fancybox-rotate{100%{transform:rotate(360deg)}}@keyframes fancybox-dash{0%{stroke-dasharray:1,200;stroke-dashoffset:0}50%{stroke-dasharray:89,200;stroke-dashoffset:-35px}100%{stroke-dasharray:89,200;stroke-dashoffset:-124px}}.fancybox__backdrop,.fancybox__caption,.fancybox__nav,.carousel__dots,.carousel__button.is-close{opacity:var(--fancybox-opacity, 1)}.fancybox__container.is-animated[aria-hidden=false] .fancybox__backdrop,.fancybox__container.is-animated[aria-hidden=false] .fancybox__caption,.fancybox__container.is-animated[aria-hidden=false] .fancybox__nav,.fancybox__container.is-animated[aria-hidden=false] .carousel__dots,.fancybox__container.is-animated[aria-hidden=false] .carousel__button.is-close{animation:.15s ease backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__backdrop,.fancybox__container.is-animated.is-closing .fancybox__caption,.fancybox__container.is-animated.is-closing .fancybox__nav,.fancybox__container.is-animated.is-closing .carousel__dots,.fancybox__container.is-animated.is-closing .carousel__button.is-close{animation:.15s ease both fancybox-fadeOut}.fancybox-fadeIn{animation:.15s ease both fancybox-fadeIn}.fancybox-fadeOut{animation:.1s ease both fancybox-fadeOut}.fancybox-zoomInUp{animation:.2s ease both fancybox-zoomInUp}.fancybox-zoomOutDown{animation:.15s ease both fancybox-zoomOutDown}.fancybox-throwOutUp{animation:.15s ease both fancybox-throwOutUp}.fancybox-throwOutDown{animation:.15s ease both fancybox-throwOutDown}@keyframes fancybox-fadeIn{from{opacity:0}to{opacity:1}}@keyframes fancybox-fadeOut{to{opacity:0}}@keyframes fancybox-zoomInUp{from{transform:scale(0.97) translate3d(0, 16px, 0);opacity:0}to{transform:scale(1) translate3d(0, 0, 0);opacity:1}}@keyframes fancybox-zoomOutDown{to{transform:scale(0.97) translate3d(0, 16px, 0);opacity:0}}@keyframes fancybox-throwOutUp{to{transform:translate3d(0, -30%, 0);opacity:0}}@keyframes fancybox-throwOutDown{to{transform:translate3d(0, 30%, 0);opacity:0}}.fancybox__carousel .carousel__slide{scrollbar-width:thin;scrollbar-color:#ccc rgba(255,255,255,.1)}.fancybox__carousel .carousel__slide::-webkit-scrollbar{width:8px;height:8px}.fancybox__carousel .carousel__slide::-webkit-scrollbar-track{background-color:rgba(255,255,255,.1)}.fancybox__carousel .carousel__slide::-webkit-scrollbar-thumb{background-color:#ccc;border-radius:2px;box-shadow:inset 0 0 4px rgba(0,0,0,.2)}.fancybox__carousel.is-draggable .fancybox__slide,.fancybox__carousel.is-draggable .fancybox__slide .fancybox__content{cursor:move;cursor:grab}.fancybox__carousel.is-dragging .fancybox__slide,.fancybox__carousel.is-dragging .fancybox__slide .fancybox__content{cursor:move;cursor:grabbing}.fancybox__carousel .fancybox__slide .fancybox__content{cursor:auto}.fancybox__carousel .fancybox__slide.can-zoom_in .fancybox__content{cursor:zoom-in}.fancybox__carousel .fancybox__slide.can-zoom_out .fancybox__content{cursor:zoom-out}.fancybox__carousel .fancybox__slide.is-draggable .fancybox__content{cursor:move;cursor:grab}.fancybox__carousel .fancybox__slide.is-dragging .fancybox__content{cursor:move;cursor:grabbing}.fancybox__image{transform-origin:0 0;user-select:none;transition:none}.has-image .fancybox__content{padding:0;background:rgba(0,0,0,0);min-height:1px}.is-closing .has-image .fancybox__content{overflow:visible}.has-image[data-image-fit=contain]{overflow:visible;touch-action:none}.has-image[data-image-fit=contain] .fancybox__content{flex-direction:row;flex-wrap:wrap}.has-image[data-image-fit=contain] .fancybox__image{max-width:100%;max-height:100%;object-fit:contain}.has-image[data-image-fit=contain-w]{overflow-x:hidden;overflow-y:auto}.has-image[data-image-fit=contain-w] .fancybox__content{min-height:auto}.has-image[data-image-fit=contain-w] .fancybox__image{max-width:100%;height:auto}.has-image[data-image-fit=cover]{overflow:visible;touch-action:none}.has-image[data-image-fit=cover] .fancybox__content{width:100%;height:100%}.has-image[data-image-fit=cover] .fancybox__image{width:100%;height:100%;object-fit:cover}.fancybox__carousel .fancybox__slide.has-iframe .fancybox__content,.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content,.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{max-width:100%;flex-shrink:1;min-height:1px;overflow:visible}.fancybox__carousel .fancybox__slide.has-iframe .fancybox__content,.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content{width:100%;height:80%}.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{width:960px;height:540px;max-width:100%;max-height:100%}.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content,.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{padding:0;background:rgba(24,24,27,.9);color:#fff}.fancybox__carousel .fancybox__slide.has-map .fancybox__content{background:#e5e3df}.fancybox__html5video,.fancybox__iframe{border:0;display:block;height:100%;width:100%;background:rgba(0,0,0,0)}.fancybox-placeholder{position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0, 0, 0, 0);white-space:nowrap;border-width:0}.fancybox__thumbs{flex:0 0 auto;position:relative;padding:0px 3px;opacity:var(--fancybox-opacity, 1)}.fancybox__container.is-animated[aria-hidden=false] .fancybox__thumbs{animation:.15s ease-in backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__thumbs{opacity:0}.fancybox__thumbs .carousel__slide{flex:0 0 auto;width:var(--fancybox-thumbs-width, 96px);margin:0;padding:8px 3px;box-sizing:content-box;display:flex;align-items:center;justify-content:center;overflow:visible;cursor:pointer}.fancybox__thumbs .carousel__slide .fancybox__thumb::after{content:"";position:absolute;top:0;left:0;right:0;bottom:0;border-width:5px;border-style:solid;border-color:var(--fancybox-accent-color, rgba(34, 213, 233, 0.96));opacity:0;transition:opacity .15s ease;border-radius:var(--fancybox-thumbs-border-radius, 4px)}.fancybox__thumbs .carousel__slide.is-nav-selected .fancybox__thumb::after{opacity:.92}.fancybox__thumbs .carousel__slide>*{pointer-events:none;user-select:none}.fancybox__thumb{position:relative;width:100%;padding-top:calc(100%/(var(--fancybox-thumbs-ratio, 1.5)));background-size:cover;background-position:center center;background-color:rgba(255,255,255,.1);background-repeat:no-repeat;border-radius:var(--fancybox-thumbs-border-radius, 4px)}.fancybox__toolbar{position:absolute;top:0;right:0;left:0;z-index:20;background:linear-gradient(to top, hsla(0deg, 0%, 0%, 0) 0%, hsla(0deg, 0%, 0%, 0.006) 8.1%, hsla(0deg, 0%, 0%, 0.021) 15.5%, hsla(0deg, 0%, 0%, 0.046) 22.5%, hsla(0deg, 0%, 0%, 0.077) 29%, hsla(0deg, 0%, 0%, 0.114) 35.3%, hsla(0deg, 0%, 0%, 0.155) 41.2%, hsla(0deg, 0%, 0%, 0.198) 47.1%, hsla(0deg, 0%, 0%, 0.242) 52.9%, hsla(0deg, 0%, 0%, 0.285) 58.8%, hsla(0deg, 0%, 0%, 0.326) 64.7%, hsla(0deg, 0%, 0%, 0.363) 71%, hsla(0deg, 0%, 0%, 0.394) 77.5%, hsla(0deg, 0%, 0%, 0.419) 84.5%, hsla(0deg, 0%, 0%, 0.434) 91.9%, hsla(0deg, 0%, 0%, 0.44) 100%);padding:0;touch-action:none;display:flex;justify-content:space-between;--carousel-button-svg-width: 20px;--carousel-button-svg-height: 20px;opacity:var(--fancybox-opacity, 1);text-shadow:var(--fancybox-toolbar-text-shadow, 1px 1px 1px rgba(0, 0, 0, 0.4))}@media all and (min-width: 1024px){.fancybox__toolbar{padding:8px}}.fancybox__container.is-animated[aria-hidden=false] .fancybox__toolbar{animation:.15s ease-in backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__toolbar{opacity:0}.fancybox__toolbar__items{display:flex}.fancybox__toolbar__items--left{margin-right:auto}.fancybox__toolbar__items--center{position:absolute;left:50%;transform:translateX(-50%)}.fancybox__toolbar__items--right{margin-left:auto}@media(max-width: 640px){.fancybox__toolbar__items--center:not(:last-child){display:none}}.fancybox__counter{min-width:72px;padding:0 10px;line-height:var(--carousel-button-height, 48px);text-align:center;font-size:17px;font-variant-numeric:tabular-nums;-webkit-font-smoothing:subpixel-antialiased}.fancybox__progress{background:var(--fancybox-accent-color, rgba(34, 213, 233, 0.96));height:3px;left:0;position:absolute;right:0;top:0;transform:scaleX(0);transform-origin:0;transition-property:transform;transition-timing-function:linear;z-index:30;user-select:none}.fancybox__container:fullscreen::backdrop{opacity:0}.fancybox__button--fullscreen g:nth-child(2){display:none}.fancybox__container:fullscreen .fancybox__button--fullscreen g:nth-child(1){display:none}.fancybox__container:fullscreen .fancybox__button--fullscreen g:nth-child(2){display:block}.fancybox__button--slideshow g:nth-child(2){display:none}.fancybox__container.has-slideshow .fancybox__button--slideshow g:nth-child(1){display:none}.fancybox__container.has-slideshow .fancybox__button--slideshow g:nth-child(2){display:block}

.fancybox__toolbar {
  padding: 0;
  color: var(--main-background);
  background: transparent !important;
  text-shadow: none !important;
}

.fancybox__container .fancybox__backdrop {
  background: var(--main-foreground-opacity-60);
}
.carousel__button .svg-icon-text {
  fill: var(--main-background);
  filter: none;
}

.fancybox__container {
  z-index: 30000;
}

.fancybox__container .swiper-button-prev,
.fancybox__container .swiper-button-next {
  border-radius: 0 !important;
}

.user-content img {
	max-width: 100%;
	height: auto !important;
}

.zoom-image {
  z-index: 100;
  max-width: unset;
  max-height: unset;
  width: auto;
  height: auto;
}

.product-terms-alert {
  border: 1px solid var(--danger);
  border-radius: var(--theme-round);
  padding: 10px;
  animation-name: shake;
  animation-delay: 1s;
  animation-iteration-count: 2;
  animation-direction: forward;
}

{# /* // Form and info */ #}

.fixed-product-form {
  background: var(--main-background);
  position: fixed;
  bottom: 0;
  left: 0;
  z-index: 1000;
  width: 100%;
  padding: 10px;
  transition: opacity .5 ease;
  box-shadow: 0 0 6px 0 rgba(#111, .2);
}

.fixed-product-image img {
  max-height: 80px;
}

.social-share-button {
  display: inline-block;
  padding: 8px;
  opacity: 0.5;
  &:hover,
  &:focus{
    opacity: 1;
  }
}

.section-products-related {
  @extend %section-padding;
}

.product-tags {
  span {
    display: inline-block;
    margin-right: 5px;
    margin-bottom: 5px;
    padding: 5px 10px;
    border-radius: 20px;
  }
}

.label-top-left {
  top: 25px;
  left: 25px;
  z-index: 2;
}

.product-image-limited {
  max-height: 320px;
  max-width: 100%;
  object-fit: contain;
}

{# /* // Variants */ #}

.variant-container{
  .btn-variant {
    cursor: pointer;
  }
}

{# /* // Seals */ #}

@media (min-width: 768px) {
  .product-seals {
    .seal {
      max-width: 220px;
    }
  }
}

.product-description {
  line-height: 1.5;
  table {
    position: relative;
    width: 100% !important;
    max-width: 600px;

    thead {
      font-weight: bold;
    }
    td {
      padding: 5px 3px;
      border: 1px solid #eee;
      width: auto;
    }
    tr:nth-of-type(odd) {
      background: #f9f9f9;
    }
    p {
      margin-bottom: 0;
    }
  }

  * {
    max-width: 100%;
  }
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  {# /* //// Components */ #}

  /* Search */

  .modal-nav-search.transition-fade,
  .modal-nav-search.modal-show {
    top: 0;
    height: 80px;
  }

  .modal-nav-search .modal-body {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 600px;
    margin: auto;
  }

  .modal-nav-search .search-form {
    position: relative;
    max-width: 600px;
    margin: 10px auto;
    float: none;
  }

  .modal-nav-search .search-input {
    padding: 15px 60px 15px 15px;
  }

  .modal-nav-search .search-close-btn {
    position: relative;
    top: initial;
    left: initial;
    margin: 0 0 0 8px;
    order: 1;
  }

  .modal-nav-search .search-suggestions {
    position: fixed;
    top: 90px;
    width: 560px;
    max-height: calc(100vh - 160px);
    margin: 10px 40px 0 0;
  }

  .modal-md-width-400px {
    width: 400px;
    max-width: 90vw;
  }

  {# /* //// Product grid */ #}

  .quickshop-image {
    position: relative;
    max-height: 100%;
  }

  .quickshop-image-container {
    max-height: 450px;
  }

  .quickshop-image-container > * {
    position: unset;
  }

  .quickshop-item-name {
    font-size: 1.75rem;
  }

  {# /* Notifications */ #}

  .notification-cart-container {
    left: initial;
    width: 320px;
  }

  .notification-cart-container.notification-fixed {
    right: 80px;
    bottom: initial;
    left: initial;
    max-width: 290px;
  }

  {# /* Tabs */ #}

  .tab-group{
    width: 100%;
    overflow-x: auto;
    white-space: normal;
    .tab{
      float: left;
    }
  }
}

{#/*============================================================================
  #Critical path utilities
==============================================================================*/#}

.visible-when-content-ready{
  visibility: visible!important;
}
.display-when-content-ready{
  display: block!important;
}


{% if settings.product_gallery_zoom == "zoom" %}
  .drift-zoom-pane {
    z-index: 2;
    background-color: var(--main-background);
  }
{% endif %}

.btn-transition .transition-container {
  position: relative;
  display: none;
  opacity: 0;
  text-align: center;
  -webkit-transition: all .5s ease;
  -ms-transition: all .5s ease;
  -moz-transition: all .5s ease;
  -o-transition: all .5s ease;
  transition: all .5s ease;
  pointer-events: none;
  cursor: not-allowed;
  transform: none;
  top: auto;
  left: auto;
}

.btn-transition .transition-container.active {
  display: block;
  opacity: 1
}
/* // Coupon input */

.coupon-action-btn[disabled],
.coupon-action-btn[disabled]:hover {
	background-color: transparent;
}

.coupon-error {
	display: flex;
	align-items: center;
	padding: 8px 10px;
	font-size: var(--font-small);
	line-height: 16px;
	text-align: left;
}

/* // Cart promotions inserted after Ajax updates */

.total-promotions-row {
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	margin-bottom: .5rem;
	color: var(--accent-color);
}

.cart-promotion-detail,
.cart-promotion-number {
	-ms-flex-preferred-size: 0;
	flex-basis: 0;
	-ms-flex-positive: 1;
	flex-grow: 1;
	max-width: 100%;
	position: relative;
	width: 100%;
	min-height: 1px;
}

.cart-promotion-number {
	-ms-flex: 0 0 auto;
	flex: 0 0 auto;
	width: auto;
	max-width: none;
	text-align: right;
}
