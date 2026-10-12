{% if store.allows_checkout_styling %}

/*============================================================================
checkout.scss.tpl

    -This file contains all the theme styles related to the checkout based on settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -static/css/custom-styles.scss.tpl --> For color and font styles related to config/settings.txt
        -static/css/style.scss.tpl --> For the rest of the theme styles

==============================================================================*/

{#/*============================================================================
  Global
==============================================================================*/#}

:root {

  {#/*============================================================================
    # Checkout tokens
  ==============================================================================*/#}

  {#### Colors settings #}

  {# Main colors #}

  {% set main_background = settings.background_color %}
  {% set main_foreground = settings.text_color %}
  {% set accent_color = settings.accent_color %}

  {% set button_background = settings.add_button_background_color %}
  {% set button_foreground = settings.add_button_foreground_color %}
  
  {% set label_background = settings.label_background_color %}
  {% set label_foreground = settings.label_foreground_color %}

  {% set header_background = settings.header_colors ? settings.header_background_color : main_background %}
  {% set header_foreground = settings.header_colors ? settings.header_foreground_color : main_foreground %}

  {#### Color tokens #}

  {# Auxiliar opacity hex levels #}
  {% set opacity_05 = '0D' %}
  {% set opacity_10 = '1A' %}
  {% set opacity_20 = '33' %}
  {% set opacity_30 = '4D' %}
  {% set opacity_50 = '80' %}
  {% set opacity_60 = '99' %}
  {% set opacity_80 = 'CC' %}

  {# Accent color #}
  --accent-color: {{ accent_color }};
  --accent-color-opacity-05: {{ accent_color }}{{ opacity_05 }};
  --accent-color-opacity-10: {{ accent_color }}{{ opacity_10 }};
  --accent-color-opacity-20: {{ accent_color }}{{ opacity_20 }};
  --accent-color-opacity-30: {{ accent_color }}{{ opacity_30 }};
  --accent-color-opacity-50: {{ accent_color }}{{ opacity_50 }};
  --accent-color-opacity-60: {{ accent_color }}{{ opacity_60 }};
  --accent-color-opacity-80: {{ accent_color }}{{ opacity_80 }};

  {# Foreground color #}
  --main-foreground: {{ main_foreground }};
  --main-foreground-opacity-05: {{ main_foreground }}{{ opacity_05 }};
  --main-foreground-opacity-10: {{ main_foreground }}{{ opacity_10 }};
  --main-foreground-opacity-20: {{ main_foreground }}{{ opacity_20 }};
  --main-foreground-opacity-30: {{ main_foreground }}{{ opacity_30 }};
  --main-foreground-opacity-50: {{ main_foreground }}{{ opacity_50 }};
  --main-foreground-opacity-60: {{ main_foreground }}{{ opacity_60 }};
  --main-foreground-opacity-80: {{ main_foreground }}{{ opacity_80 }};

  {# Background color #}
  --main-background: {{ main_background }};
  --main-background-opacity-05: {{ main_background }}{{ opacity_05 }};
  --main-background-opacity-10: {{ main_background }}{{ opacity_10 }};
  --main-background-opacity-20: {{ main_background }}{{ opacity_20 }};
  --main-background-opacity-30: {{ main_background }}{{ opacity_30 }};
  --main-background-opacity-50: {{ main_background }}{{ opacity_50 }};
  --main-background-opacity-60: {{ main_background }}{{ opacity_60 }};
  --main-background-opacity-80: {{ main_background }}{{ opacity_80 }};

  {#### Component tokens #}

  {# General #}
  --border-radius: 3px;
  --box-border-radius: var(--border-radius);
  --border-color: var(--main-foreground-opacity-30);

  {# Buttons #}
  --button-foreground: {{ button_foreground }};
  --button-background: {{ button_background }};
  --button-border-color: var(--button-background);
  --button-border-radius: var(--border-radius);

  {# Labels #}
  --label-foreground: {{ label_foreground }};
  --label-background: {{ label_background }};

  --label-primary-background: var(--label-background);
  --label-primary-border-color: var(--label-background);
  --label-primary-foreground: var(--label-foreground);
  --label-primary-border-radius: var(--border-radius);

  {# Header #}
  --header-foreground: {{ header_foreground }};
  --header-background: {{ header_background }};
  --header-logo-max-width: 50%;
  --header-logo-max-height: 50px;

  {# Footer #}
  --footer-foreground: {{ settings.footer_colors ? settings.footer_foreground_color : main_foreground }};
  --footer-background: {{ settings.footer_colors ? settings.footer_background_color : main_background }};

  {#### Typography #}

  {# Headings #}
  --heading-font: {{ settings.font_headings | default('Open Sans Condensed') | raw }};
  --heading-font-weight: bold;
  --heading-text-transform: none;
  --heading-letter-spacing: normal;

  {# Header #}
  --header-logo-font: var(--heading-font);
  --header-logo-font-size: 34px;
  --header-logo-font-weight: 700;
  --header-logo-text-transform: none;
  --header-logo-letter-spacing: normal;

  {# Body #}
  --body-font: {{ settings.font_rest | default('Open Sans Condensed') | raw }};
}

$primary-brand-color: {{ settings.primary_color | default('rgb(77, 190, 207)' | raw ) }};
$foreground-color: {{ settings.text_color | default('rgb(102, 102, 102)' | raw ) }};
$background-color: {{ settings.background_color | default('rgb(252, 252, 252)' | raw ) }};
$secondary-color: {{ settings.secondary_color | default('rgb(170, 198, 123)' | raw) }};
$black: #000000;

{# /* // Font */ #}

@import url('https://fonts.googleapis.com/css?family=Barlow:400,700|Bree+Serif:400,700|Inter:400,700|Nunito:400,700|Quicksand:400,700|Montserrat:400,700|Playfair+Display:400,700|Rubik:400,700|Roboto:400,700|Roboto+Condensed:400,700|Roboto+Slab:400,700|Raleway:400,700|Josefin+Sans:400,700|Lato:400,700|Libre+Baskerville:400,700|Merriweather:400,700|Open+Sans:400,700|Slabo+27px|Lora:400,700|Droid+Sans:400,700|Poppins:400,700|Cinzel:400,700&display=swap');

$heading-font: {{ settings.font_headings | default('Open Sans Condensed') | raw }};
$body-font: {{ settings.font_rest | default('Open Sans Condensed') | raw }};

{# /* // Box */ #}

$box-radius: 3px;
$box-background: lighten($background-color, 5%);

$box-border-color: rgba($foreground-color, .3);
$box-background: lighten($background-color, 10%);
$box-shadow: none;

{# /* // Functions */ #}

@function brightness($color) {
  $sum: red($color) + green($color) + blue($color);
  @return percentage($sum / (255*3));
}

@function set-background-color($background-color) {
  @if lightness($background-color) > 95% {
    @return lighten($background-color, 10%);
  } @else {
    @return desaturate(lighten($background-color, 7%), 5%);
  }
}

@function set-input-color($background-color, $foreground-color) {
  @if lightness($background-color) > 70% {
    @return desaturate(lighten($foreground-color, 5%), 80%);
  } @else {
    @return desaturate(lighten($background-color, 5%), 80%);
  }
}

@function dcolor() {
  $brand-color: {{ settings.brand_color | default('rgb(77, 190, 207)' | raw ) }};;
  $primary-color: {{ settings.primary_color | default('rgb(252, 252, 252)' | raw ) }};
  $secondary-color: {{ settings.secondary_color | default('rgb(102, 102, 102)' | raw ) }};

  @if (brightness($secondary-color) > 50) {
    @return $brand-color; // Lighter background, return dark color
  } @else {
    @return $secondary-color; // Darker background, return light color
  }
}

$tertiary-color: dcolor();

{% if not store.is_react_checkout_eligible %}

{#/*============================================================================
  New-checkout
==============================================================================*/#}

body {
  font-family: var(--body-font);
  background-color: $background-color;
}
.main-container {
  background-color: $background-color;
}
.header { 
  background-color: lighten($background-color, 10%);
  border-bottom: 2px solid $primary-brand-color;
}
.form-box {
  border-radius: $box-radius;
  padding: 10px 20px 20px 20px;
  background: lighten($background-color, 10%);
  border: 1px solid $box-border-color;
}
.form-box h1 {
  margin-bottom: 0;
  font-family: $heading-font;
  color: $foreground-color;
  text-shadow: none;
  text-transform: uppercase;
  border-bottom: none;
}
.form-control {
  background: lighten($primary-brand-color, 100%);
}
.form-control:focus, select:focus, textarea:focus {
  border-color: $primary-brand-color !important;
  outline: none;
}
.input-group-addon-focus {
  border-color: $primary-brand-color !important;
}
.whatsapp-content .whatsapp-form {
  input, .input-group-addon {
    border-color: $primary-brand-color;    
  }
}

.form-control-help {
  color: $primary-brand-color;

  &-icon {
    background-color: $primary-brand-color;
    color: $background-color;

    &:hover {
      color: $background-color;
    }

    &.pressed {
      background-color: $background-color;
      border-color: $box-border-color;
      color: $primary-brand-color;
    }
  }
}
.form-control-help-content {
  background-color: $primary-brand-color;

  .arrow-up {
    border-bottom-color: $primary-brand-color;
  }
  a {
    color: $background-color;
  }
}

input[type=submit], 
button[type=submit], 
.btn-checkout {
  font-family: $heading-font;
  text-transform: uppercase;
  border-radius: 3px;
  color: var(--button-foreground);
  background-color: var(--button-background);
}
.login-btn a,
.login-btn a:hover,
.btn-link,
.btn-link:hover {
  color: $primary-brand-color;
}


input[type=submit]:hover, 
input[type=submit]:focus, 
input[type=submit]:active, 
button[type=submit]:hover, 
button[type=submit]:focus, 
button[type=submit]:active,
.btn-checkout:hover,
.btn-checkout:focus,
.btn-checkout:active,
.ticket-container .ticket-txt a:hover {
  color: $background-color;
  background-color: darken($primary-brand-color, 10%);
  border-color: rgba($primary-brand-color, 0.6);
  text-decoration: none;
}

#breadcrumb{
  list-style:none;
  display: inline-block;
  padding: 0;
  margin: 0 0 10px 0;
  
  li{
    float:left;
    a{
      color:lighten($foreground-color, 100%);
      display:block;
      background: $primary-brand-color;
      text-decoration: none;
      position:relative;
      height: 30px;
      line-height:30px;
      padding: 0 10px 0 5px;
      text-align: center;
      margin-right: 23px;
    }
    &:first-child{
      a{
        padding-left:15px;
        border-radius: $box-radius 0 0 $box-radius;
        &:before{
          border:none;
         }
      }
      a.inactive:before{
        border-width: 0;
      }
      a.inactive:after{
        border-left-color: rgba($primary-brand-color, 0.3);
      }
    }

    &:last-child{
      a{
        padding-right:15px;
        border-radius: 0;
        &:after{
          border:none;
        }
      }
    }
    
    a{   
      &:before,
      &:after{
        content: "";
        position:absolute;
        top: 0;
        border:0 solid $primary-brand-color;
        border-width:15px 10px;
        width: 0;
        height: 0;
      }
      &:before{
        left:-20px;
        border-left-color:transparent;
      }
      &:after{
        left:100%;
        border-color:transparent;
        border-left-color:$primary-brand-color;
      }
      &:hover{
        opacity: 0.8;
        
        &:before{
          border-left-color:transparent;
         }
      }
      &:active{
        background-color: $primary-brand-color;
        
        &:before{
          border-color:$primary-brand-color;
          border-left-color:transparent;
         }
        &:after{
          border-left-color:$primary-brand-color;
        }
      }
    }
    a.previous {
        opacity: 0.6;
      &:hover{
        opacity: 1;
      }
    }
    a.inactive {
      background: rgba($primary-brand-color, 0.3);
      cursor: default;
      color: darken($primary-brand-color, 40%);
      &:before {
        content: "";
        position:absolute;
        top: 0;
        border:0 solid rgba($primary-brand-color, 0.3);
        border-width:15px 10px;
        width: 0;
        height: 0;
      }
      &:hover{
        opacity: 1;
      }
      &:before{
        left:-20px;
        border-left-color:transparent;
      }
      &:active{
        background-color: rgba($primary-brand-color, 0.3);
        
        &:before{
          border-color:rgba($primary-brand-color, 0.3);
          border-left-color:transparent;
         }
      }
    }
  }
}

div.help {
  background-color: $background-color;
  color: $foreground-color;
  border-radius: $box-radius;
  a {
    color: $foreground-color;
  }
  &-warning {
    background-color: #DB3E3E;
    color: #fff;
  }
}

.form-divider {
  .form-divider-title {
    color: rgba($primary-brand-color, 0.3);
    background-color: $background-color;
  }
  hr {
    border-top-color: rgba($primary-brand-color, 0.3);
  }
}

.custom-checkbox > .box > .tick {
  border-bottom-color: $primary-brand-color;
  border-left-color: $primary-brand-color;
}
.customOption input:checked + label {
  border-color: $primary-brand-color;
}
.customOption input:checked + label span.custom-radio {
  background: $primary-brand-color;
}
.customOption.pickup label {
  border-color: rgba($primary-brand-color, 0.3);
}
.customOption input:checked + label .description .name {
  color: $primary-brand-color;
}

.thankyou .success-msg a {
  color: $primary-brand-color;
}
.thankyou .success-msg .title h1, .thankyou .success-msg h3, .thankyou .form-box .create-account span.label-email {
  font-family: $heading-font;
}

h5 {
  color: $foreground-color;
}
.form-control, select {
  border-color: rgba($primary-brand-color, 0.3);
  border-radius: 3px;
}
.table::-webkit-scrollbar-thumb {
  background-color: $primary-brand-color;
}
.table-striped > tbody > tr:first-child {
  border-top: none;
}
.table-striped > tbody > tr:nth-of-type(odd) {
  border-top: 1px dotted rgba($primary-brand-color, 0.03);
  background: rgba($foreground-color, 0.05);
}
.table-striped > tbody > tr:nth-of-type(even) {
  border-top: 1px dotted rgba($primary-brand-color, 0.1);
  background: rgba($foreground-color, 0.01);
}
.header .header-container {
  padding-left: 0;
}
.header .header-container .store-name {
  padding-left: 0;
  text-align: left;
}
.header .header-container .store-name img {
  padding-top: 5px;
}
.summary-container .summary #total-box .table {
  border-radius: 3px 3px 0 0;
}
.summary-container .summary .table td {
  color: $foreground-color;
}
.summary-container .summary #total-box .table.total-table {
  border-radius: 0 0 3px 3px;
}
.summary-container .summary #total-box .table.total-table tr td {
  color: $primary-brand-color;
}
.summary-container .summary .slidingDiv {
  background-color: lighten($background-color, 10%);
  border-radius: 3px;
} 
.summary-container .summary #total-box .table tbody.total {
  border-color: $primary-brand-color;
}
.summary-container .summary #total-box .table .success {
  border-color: $primary-brand-color;
}
.summary-container .summary #total-box .table tbody.total tr { 
  background: $background-color;
}
.summary-container .summary .show-cart-button .fa-circle, .summary-container .summary .show-cart-button .show-details {
  color: $primary-brand-color;
}
.summary-container .summary .show-cart-button span.total-cart {
  margin-top: 2px;
  background-color: $primary-brand-color;
}
.summary-container .summary #coupon-form .coupon-field button {
  background: $primary-brand-color;
  border: 1px solid $primary-brand-color;
}
.summary-container .summary #total-box .table tbody.total tr.discount {
  background-color: rgba($primary-brand-color, 0.1);
  color: $primary-brand-color;
}
.summary-container .summary #total-box .table .success td {
  color: $foreground-color;
  background-color: $primary-brand-color;
}
.summary-container .summary #total-box .table.total-table tr.success td {
  color: lighten($background-color, 10%);
}

.error-msg-single, .bg-danger, .bg-success {
  border-radius: 3px;
}
.text-muted {
  color: rgba($foreground-color, 0.6);
}
.text-primary {
  color: $primary-brand-color;
}
.seals {
  border-color: rgba($primary-brand-color, 0.3);
}
.ticket-container .ticket-txt a, .custom-container .ticket-txt a {
  font-family: $heading-font;
  text-transform: uppercase;
  border-radius: 3px;
  background-color: $primary-brand-color;
}

.ac-container {
  border-color: rgba($primary-brand-color, 0.1);
}
.ac-container label.accordion {
  font-family: $heading-font;
  color: $foreground-color;
  text-shadow: none;
  border-bottom-color: rgba($primary-brand-color, 0.1);
  background: rgba($background-color, 0.3);
}
.ac-container label.accordion:hover {
  background: rgba($background-color, 0.02);
}
.ac-container input.accordion:checked + label span {
  background: $primary-brand-color;
}
.ac-container, .summary-container .summary .show-cart-button span.total-cart {
  font-family: $heading-font;
  border-radius: $box-radius;
}
.ac-container article {
  box-shadow: 0px 3px 0px 0px $primary-brand-color inset;
  background-color: rgba($background-color, 0.8);
}
.ac-container div:first-child label.accordion {
  border-radius: $box-radius $box-radius 0 0;
}
.ac-container div:last-child label.accordion {
  border-radius: 0 0 $box-radius $box-radius;
}
.ac-container input.accordion:checked + label.accordion, 
.ac-container input.accordion:checked + label.accordion:hover
 {
  background-color: $primary-brand-color;
  text-shadow: none;
  color: lighten($background-color, 10%);
}
.ac-container input.accordion:checked ~ article {
  background: rgba($foreground-color, 0.05);
  box-shadow: none;
}
.ac-container div:last-child input.accordion:checked + label.accordion {
    border-radius: 0;
    border-bottom: 1px solid rgba($primary-brand-color, 0.1);
}

.ac-container label.accordion p.tag-discount {
  color: lighten($background-color, 10%);
  background-color: $primary-brand-color;
}
.ac-container input.accordion:checked + label.accordion p.tag-discount {
  color: $primary-brand-color;
  background-color: lighten($background-color, 10%);
}

.thankyou .form-box {
  overflow: hidden;
}
.thankyou .form-box .create-account {
  padding: 10px 20px 20px 20px;
  color: lighten($background-color, 70%);
  background: rgba($foreground-color, 0.05);
  border-radius: $box-radius;
  border: none;
}
.thankyou .form-box p {
  padding: 25px 0;
  margin-bottom: 20px;
  border-bottom: 1px solid $background-color;
}
.thankyou .form-box .create-account p {
  padding: 0;
  margin: 0;
  color: $foreground-color;
  border-bottom: none;
}
.create-account .label-email {
  font-weight: bold;
  color: $foreground-color;
  letter-spacing: 1px;
}
.thankyou .form-box .ticket-container {
  margin: 0 0 10px 0;
}
.form-password .btn-submit {
  float: none;
  margin-top: 4px;
  display: inline-block;
}
.coupon-show-link, .submit-coupon-btn i.fa-stack-2x {
  color: $primary-brand-color;
}
.coupon-show-link {
  border-radius: $box-radius;
}
.submit-coupon-btn:active i.fa-stack-2x {
  color: darken($primary-brand-color, 10%);
}
.coupon-success {
  background: $primary-brand-color;
  border-radius: 0;
  font-size: 14px;
}
.coupon-success .arrow-up {
  border-bottom-color: $primary-brand-color;
}
@media (min-width: 768px) {
  .thankyou .form-box .ticket-txt p {
    text-align: left;
  }
}
@media (min-width: 992px) {
  .thankyou .success-msg {
      width: 66%;
  }
}

.announcement {
  color: darken($primary-brand-color, 10%);

  &-bg {
    background: $primary-brand-color;
    box-shadow: 0px 3px 5px -1px rgba(darken($primary-brand-color, 20%), 0.35);
    border-radius: $box-radius;
  }

  &-close {
    color: $primary-brand-color;
  }
}

{% else %}


{#/*============================================================================
  React
==============================================================================*/#}

{# /* // Box */ #}

$box-background: lighten($background-color, 10%);
$box-text-shadow: null;
@if lightness($foreground-color) > 95% {
  $box-text-shadow: 0 2px 1px rgba(darken($foreground-color, 80%), 0.1);
} @else {
  $box-text-shadow: 0 2px 1px rgba(lighten($foreground-color, 80%), 0.1);
}

$base-red: #c13a3a;

$xs: 0;
$sm: 576px;
$md: 768px;
$lg: 992px;
$xl: 1200px;

body {
  font-family: $body-font;
  color: $foreground-color;
  background-color: $background-color;
}
a {
  color: var(--main-foreground);
  text-decoration: none;

  &:hover, &:focus {
    color: var(--main-foreground-opacity-50);
    
    svg {
      fill: var(--main-foreground-opacity-50);
    }
  }
  
  svg {
    fill: $primary-brand-color;
  }
}

{# /* // Text */ #}

.title {
  color: $foreground-color;
}

{# /* // Header */ #}

.header { 
  background-color: lighten($background-color, 10%);
  border-color: $primary-brand-color;
}
.security-seal {
  font-size: 10px;
  color: var(--header-foreground);
  @media (max-width: $sm) {
    color: #000000;

    .d-inline-block:first-child {
      position: absolute;
      top: 1px;
      left: 50%;
      margin-left: -13px;
    }
    p {
      display: inline-block;
      &.text-semi-bold {
        margin-right: 50px !important;
      }
    }
    &-badge {
      margin: 0;
    }
  }
}

{# /* // Headbar */ #}

.headbar {
  background: var(--header-background);
  color: var(--header-foreground);
  box-shadow: none;

  .container {
    .row {
      -ms-flex-align: center!important;
      align-items: center!important;
      @media (max-width: $sm) {
        .col {
          text-align: center !important;
          flex-basis: auto;
          &.text-left {
            order: 2;
          }
          &.text-right {
            margin: -12px 0 15px 0;
            background: #aac67b;
          }
        }
      }
    }
  }
}


.headbar-logo-img {
  {% if settings.logo_desktop_height %}
    max-height: {{ settings.logo_desktop_height }}px;
  {% else %}
    max-height: 50px;
  {% endif %}
  max-width: 50%;
}

{% if settings.logo_mobile_height %}
@media (max-width: 767px) {
  .headbar-logo-img {
    max-height: {{ settings.logo_mobile_height }}px;
  }
}
{% endif %}

.headbar-logo-text {
  float: none;
  font-family: $heading-font;
  font-size: 34px;
  font-weight: 700;
  color: var(--header-foreground);
}

.headbar-continue {
  margin: 0 !important;
  font-weight: 400;
  color: var(--header-foreground);
  &:hover,
  &:focus {
    opacity: .8;
  }
  &-icon {
    margin-left: 5px;
    fill: var(--header-foreground);
  }
}

{# /* // Form */ #}

.form-control {
  color: $foreground-color;
  background-color: $background-color;
  border-color: $box-border-color;
  border-radius: $box-radius;
  font-family: $body-font;

  &:focus {
    border-color: $foreground-color;
    outline: none;    
  }
}
.form-options-content {
  font-size: 12px;
  line-height: 20px;
  color: rgba($foreground-color, .6);
  border: 0;
}
.form-group {

  &-error { 

  .form-control {
      border-color: $base-red;

      &:focus {
        border-color: $base-red;
      }
    }
  }
}
.form-group input[type="radio"] + .form-options-content {
  .unchecked {
    fill: darken($background-color, 10%);
  }
  .checked {
    fill: $primary-brand-color;
  }
}
.form-group input[type="radio"]:checked + .form-options-content {
  border: 1px solid $primary-brand-color;
  border-color: darken($background-color, 10%);
  
  + .form-options-accordion {
    border-color: darken($background-color, 10%);
  }
  
  .checked {
    fill: $primary-brand-color;
  }
}
.form-group input[type="checkbox"]:checked + .form-options-content {
  .checked {
    fill: $foreground-color;
  }
}
.form-group input[disabled] + .form-options-content {
  border-color: darken($background-color, 10%) !important;
  
  .form-options-label {
    color: $foreground-color !important;
  }
  .checked {
    fill: $foreground-color !important;
  }
}
.form-group input[type="checkbox"] + .form-options-content {
  .unchecked {
    width: 13px;
    fill: $foreground-color;
  }
}

{# /* // Input */ #}

.has-float-label>span,
.has-float-label label {
  padding: 1px 0 0 7px;
  font-weight: 400;
}

.input-label {
  color: $foreground-color;
}

.select-icon {
  fill: $foreground-color;
}

{# /* // Buttons */ #}

.btn {
  border-radius: $box-radius;
}

.btn-primary {
  color: var(--button-foreground);
  background: var(--button-background);
  font-family: var(--body-font);

  &:hover,
  &:focus,
  &:active {
    color: var(--button-foreground);
    background: var(--button-background);
    opacity: 0.9;
  }
}
.btn-secondary {
  background: var(--main-background);
  color: var(--main-foreground);
  border-color: var(--main-foreground);

  &:hover,
  &:focus,
  &:active,
  &:active:focus {
    background: var(--main-foreground-opacity-05);
    border-color: var(--main-foreground-opacity-80);
  }
  &.btn-icon-right {

    svg {
      fill: $foreground-color;
    }
  }
}
.btn-transparent {
  color: var(--main-foreground);

  &:hover {
    color: var(--main-foreground-opacity-80);
    
    .btn-icon-right {
      fill: var(--main-foreground-opacity-80);
    }
  }
  
  .btn-icon-right {
    fill: var(--main-foreground);
  }
}

.btn-link {
  color: $foreground-color;
  text-decoration: none;

  &:hover {
    color: rgba($foreground-color, .8);

    svg {
      fill: rgba($foreground-color, .8);
    }
  }
}

.btn-picker {
  border-color: $box-border-color;
}

.login-info {
  margin: 10px 0 0;
  font-size: 12px;
  color: rgba($foreground-color, .6);
  text-align: left;
}

{# /* // Breadcrumb */ #}


.breadcrumb {
  margin: 0;

  &:before {
    position: absolute;
    left: 0;
    width: 100%;
    height: 55px;
    background: rgba($foreground-color, .03);
    content: '';
  }

  li {

    &:last-child {
      .breadcrumb-step {
        border-radius: $box-radius;
      }
    }

    .breadcrumb-step {
      height: 55px;
      margin: 0;
      font-size: 13px;
      color: rgba($foreground-color, .6);
      background: none;
      text-transform: none;
      font-family: $body-font;

      &.active {
        color: $foreground-color;
        background: none;

        &:before,
        &:after {
          position: relative;
          margin: 0 10px;
          border: 0;
          content: "-";
          opacity: .6;
        }
      }

      &.visited {
        color: rgba($foreground-color, .6);
        background: none;
      }
    }
    &:first-child .breadcrumb-step,
    &:last-child .breadcrumb-step {
      padding: 0;
    }
  }
}

{# /* // Accordion */ #}

.accordion {
  border-radius: $box-radius;

  @if lightness($background-color) < 10% {
    border-color: rgba($box-border-color, 0.7);
  } @else {
    border-color: rgba($box-border-color, 0.7);
  }
  
  &.open {
    border-color: darken($foreground-color, 10%);
  }

  .section {
    border-color: rgba($box-border-color, 0.5);

    &:last-child {
      border-radius: $box-radius;
    }
  }

  .section-body {
    @if lightness($background-color) < 10% {
      background: desaturate($background-color, 10%);
    } @else {
      background: desaturate(darken($background-color, 1%), 10%);
    }
    border-color: $foreground-color;
  }
}

{# /* // Summary */ #}

.mobile-discount-coupon_btn {
  border-radius: $box-radius;
  border-color: darken($background-color, 10%);
  color: lighten($foreground-color, 20%);
  
  .icon {
    color: lighten($foreground-color, 20%);
  }
}
.summary {
  
  .panel {
    @media (max-width: $sm) {
      border: 0;
    }
  }
}
.summary-container {
  background: $foreground-color;
  box-shadow: none;
}
.summary-total {
  font-size: 16px;
  color: $background-color;
  background: none;
  padding: 2px 0;
}
.summary-img-thumb {
  background: none;
  border-radius: $box-radius;
}
.summary-arrow {
  &-rounded {
    background: none;
    border: 1px solid $background-color;
    .summary-arrow-icon {
      fill: $background-color;
    }
  }
}
.summary-arrow-icon {
  fill: $foreground-color;
}
.summary-title {
  color: $background-color;
}
.summary-coupon {
  padding: 15px;
  background: $background-color;
  @media (max-width: 767px) {
    padding: 15px 0 !important;
  }
}

{# /* // Radio */ #}

.radio-group {
  border-radius: $box-radius;
}
.radio-group-accordion {
  border: 0;

  .radio {
    margin-bottom: 15px;
    border: 1px solid $box-border-color;

    &.active {
      margin: 0;
      color: $primary-brand-color;
      border: 2px solid $primary-brand-color;
      border-bottom: none;
      border-left-width: 5px;
      .label {
        color: $foreground-color;
      }
      & + .radio-content {
        margin-bottom: 15px;
        padding-top: 5px;
        border: 2px solid $primary-brand-color;
        border-top: none;
        border-left-width: 5px;
      }
    }
    .label {
      font-size: 16px;
      font-weight: 700;
      color: rgba($foreground-color, .6);
    }
    .description {
      width: calc(100% - 35px);
      margin-left: 35px;
      font-weight: 400;
    }
    &:last-child {
      border-bottom: 1px solid $box-border-color;
      border-radius: $box-radius;
    }
  }

  .radio-content:last-child {
    border-radius: $box-radius;
  }
}

.radio {

  input {

    &:checked + .selector:before {
      background: none;
      border-color: $primary-brand-color;
    }
    &:checked + .selector:after {
      position: absolute;
      top: 2px;
      left: 4px;
      width: 12px;
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%23{{ settings.brand_color |trim('#') }}"><path d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"/></svg>');
    }
    &:disabled:checked + .selector:before {
      background-image: radial-gradient(circle, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.5) 50%, transparent 50%, transparent 100%);
    }
  }
  .selector {
    position: relative;
    margin-top: -1px;

    &:before {
      width: 20px;
      height: 20px;
      margin: 0 15px 0 0;
      border: 2px solid rgba($foreground-color, .5);
      border-radius: 0;
      vertical-align: middle;
    }
  }
}
.radio-content {
  background: $background-color;
  border: 1px solid $box-border-color;
  box-shadow: none;
}
.shipping-option {
  margin-bottom: 15px;
  border-radius: $box-radius;
  border-color: $box-border-color;

  &.active {
    border: 2px solid $primary-brand-color;
    border-left-width: 5px;
    .shipping-method-item-price {
      color: $foreground-color;
    }
  }
}

{# /* // Panel */ #}

.panel {
  padding: 0;
  color: $foreground-color;
  background-color: $background-color;
  text-align: left;
  border-radius: $box-radius;
  box-shadow: none;
  border: 0;

  &.summary-details {
    color: $foreground-color;
    background: $background-color;
    box-shadow: -2px 3px 7px 3px rgba($foreground-color,0.1);
  }
  .panel-subheader:before {
    display: inline-block;
    width: 20px;
    margin: 0 14px 0 2px;
    vertical-align: middle;
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512" fill="%23{{ settings.secondary_color |trim('#') }}"><path d="M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm128 421.6c-35.9 26.5-80.1 42.4-128 42.4s-92.1-15.9-128-42.4V416c0-35.3 28.7-64 64-64 11.1 0 27.5 11.4 64 11.4 36.6 0 52.8-11.4 64-11.4 35.3 0 64 28.7 64 64v13.6zm30.6-27.5c-6.8-46.4-46.3-82.1-94.6-82.1-20.5 0-30.4 11.4-64 11.4S204.6 320 184 320c-48.3 0-87.8 35.7-94.6 82.1C53.9 363.6 32 312.4 32 256c0-119.1 96.9-216 216-216s216 96.9 216 216c0 56.4-21.9 107.6-57.4 146.1zM248 120c-48.6 0-88 39.4-88 88s39.4 88 88 88 88-39.4 88-88-39.4-88-88-88zm0 144c-30.9 0-56-25.1-56-56s25.1-56 56-56 56 25.1 56 56-25.1 56-56 56z"/></svg>');
  }
  .panel-submodule:last-child .panel-subheader:before,
  .shipping-options .panel-subheader:before {
    width: 18px;
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" fill="%23{{ settings.secondary_color |trim('#') }}"><path d="M192 96c-52.935 0-96 43.065-96 96s43.065 96 96 96 96-43.065 96-96-43.065-96-96-96zm0 160c-35.29 0-64-28.71-64-64s28.71-64 64-64 64 28.71 64 64-28.71 64-64 64zm0-256C85.961 0 0 85.961 0 192c0 77.413 26.97 99.031 172.268 309.67 9.534 13.772 29.929 13.774 39.465 0C357.03 291.031 384 269.413 384 192 384 85.961 298.039 0 192 0zm0 473.931C52.705 272.488 32 256.494 32 192c0-42.738 16.643-82.917 46.863-113.137S149.262 32 192 32s82.917 16.643 113.137 46.863S352 149.262 352 192c0 64.49-20.692 80.47-160 281.931z"/></svg>');
  }
}
.panel-header {
  position: relative;
  display: flex;
  flex-direction: row;
  margin: 0 0 15px 0;
  font-family: $heading-font;
  font-size: 24px;
  font-weight: bold;
  color: $foreground-color;
  background: $background-color;
  border: 0;
  text-shadow: none;
  @media (max-width: $sm) {
    font-size: 22px;
  }
}
.panel-header-tooltip {
  position: absolute;
  top: 0;
  right: 0;

  .tooltip-icon {
    fill: lighten($foreground-color, 20%);
  }
  &:hover {
    .tooltip-icon {
      fill: $foreground-color;
    }
  }
}
.panel-header-sticky {
  background-color: $background-color;
}
.panel-footer {
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
  background: darken($background-color, 2%);
  &-wa {
    border-color: darken($background-color, 5%);
  }
}
.panel-footer-form {
  input {
    border-color: $foreground-color;
  }
  .input-group-addon {
    background: $background-color;
    border-color: $foreground-color;
  }
  .disabled {
    background: darken($background-color, 15%) !important;
  }
}

{# /* // Table */ #}

.table-footer {
  display: block;
  margin-top: 15px;
  font-size: 22px;
  font-weight: 700;
  color: var(--main-foreground);
  border-top: 1px solid rgba($background-color, 0.2);

  .text-semi-bold {
    font-weight: 400;
  }
}

.table-subtotal {
  padding: 15px 0 0;
  border-color: rgba($background-color, .2);

  td {
    padding: 3px 0;
  }
  .table tr {
    display: block;
    line-height: 1.5;
    padding: 5px 0;
  }
  .table-footer td {
    padding: 20px 0;
  }
}

.table {
  .table-discount-coupon, .table-discount-promotion {
    border-color: rgba($foreground-color, 0.09);
    color: $primary-brand-color;
  }
}

{# /* // Shipping Options */ #}

.shipping-options {
  color: lighten($foreground-color, 7%);
}

.shipping-method-item > span {
  width: 100%;
}

.shipping-method-item-desc,
.shipping-method-item-name {
  max-width: 70%;
  color: desaturate(lighten($foreground-color, 10%), 80%)
}

.shipping-method-item-price {
  float: right;
  font-size: 18px;
  color: rgba($foreground-color, .6);
}

.price-striked {
  display: block;
  margin: 5px 0 0 !important;
  font-size: 14px;
  color: rgba($foreground-color, .6);
  text-align: right;
}

{# /* // Discount Coupon */ #}

.box-discount-coupon {

  button {
    @if lightness($foreground-color) < 90% {
      color: lighten($foreground-color, 80%);
    } @else {
      color: $foreground-color;
    }
    background: $primary-brand-color;

    &:hover {
      background: lighten($primary-brand-color, 15%) radial-gradient(circle,transparent 1%, lighten($primary-brand-color, 15%) 1%) center/15000%;
    }
  }
}
.box-discount-coupon-applied {
  background-color: rgba(darken($background-color, 5%), 0.5);
  border: 0;
  border-radius: $box-radius;
  color: $primary-brand-color;

  .coupon-icon {
    fill: $foreground-color;
  }
}

{# /* // Order Status */ #}

.orderstatus {
  border: 1px solid $box-border-color;
}

.orderstatus-footer {
  @media (max-width: $sm) {
    background: $background-color;
  }
}

{# /* // Destination */ #}

.destination {
  border-color: $box-border-color;
}

.destination-icon {
  svg {
    fill: $primary-brand-color;
  }
}

{# /* // User Detail */ #}

.user-detail-icon {
  svg {
    fill: $primary-brand-color;
  }
}

{# /* // History */ #}

.history-item {

  &-done {
    .history-item {
      &-title {
        color: $primary-brand-color;
      }
    }
  }
  &-failure {
    .history-item {
      &-title {
        color: $base-red;
      }
    }
  }
}
.history-item-progress-icon {

  svg {
    @if lightness($background-color) > 50% {
      fill: darken($background-color, 10%);  
    } @else {
      fill: $background-color;
    }
  }
  &:after {
    @if lightness($background-color) > 50% {
      fill: darken($background-color, 10%);
      border-color: darken($background-color, 10%);
    } @else {
      fill: $background-color;
      border-color: $background-color;
    }
  }
  &-failure {
    svg {
      fill: $base-red;
    }
  }
  &-success {
    svg {
      fill: $primary-brand-color;
    }
    &:after {
      border-color: $primary-brand-color;
    }
  }
}

{# /* // History Cancelled */ #}

.history-canceled {
  border-top-right-radius: $box-radius;
  border-top-left-radius: $box-radius;
  
  &-round {
    border-bottom-right-radius: $box-radius;
    border-bottom-left-radius: $box-radius;
  }
}
.history-canceled-header {
  border-color: rgba($box-border-color, 0.7);
  border-top-left-radius: $box-radius;
  border-top-right-radius: $box-radius;
}
.history-canceled-icon {
  svg {
    fill: darken($background-color, 45%);
  }
}

{# /* // Offline Payment */ #}

.ticket-coupon {
  background: darken($background-color, 4%);
  border-color: $box-border-color;
}

{# /* // Status */ #}

.status {
  border: 1px solid $box-border-color; 
  padding: 25px 0;
  @media (min-width: $md) {
    padding: 40px 0;
  }
}
.status-icon {
  svg {
    fill: $primary-brand-color;
  }
}

{# /* // Tracking */ #}

.tracking-item-time {
  color: $foreground-color;
}

{# /* // WhatsApp Opt-in */ #}

.whatsapp-form {
  input, 
  .input-group-addon {
    border-color: $primary-brand-color;
  }
}

{# /* // Helpers */ #}

.border-top {
  border-color: rgba($box-border-color, .4);
}

{# /* // Errors */ #}

.alert-info {
  background-color: #fcf8e3;
  border: 1px solid #f7ecb5;
  border-radius: 4px;
  color: #525153;
}

.alert-info .alert-icon {
    fill: #525153;
}

.alert-danger-bagged {
  margin: 0;
  padding-top: 6px;
  border-bottom-left-radius: $box-radius;
  border-bottom-right-radius: $box-radius;
}

.general-error {
  background: $base-red;
  border-color: lighten($base-red, 10%);
}

{# /* // Badge */ #}

.badge {
  border: 0;
}

{# /* // Payment */ #}

.payment-item-discount {
  background-color: $primary-brand-color;
  color: $background-color;
  border-radius: $box-radius;
  padding: 5px;
}

{# /* // Overlay */ #}

.overlay {
  background: rgba(darken($background-color, 10%), 0.6);
}
.overlay-title {
  color: rgba($foreground-color, .7);
}

{# /* // List Picker */ #}

.list-picker {

  .unchecked {
    fill: $foreground-color;
  }
  li {
    border-color: $box-border-color;
    background: lighten($background-color, 10%);

    &:hover {
      color: $primary-brand-color;
    }

    &.active {
      background: $background-color;
      color: $primary-brand-color;

      .checked {
        fill: $primary-brand-color;
      }
    }
  }
}
.list-picker-content {
  background: lighten($background-color, 10%);
  border-color: $box-border-color;
}

{# /* // Loading */ #}

.loading {
  background: rgba(darken($background-color, 2%), 0.5);
  color: $primary-brand-color;
}
.loading-spinner {
  color: $primary-brand-color;
}

.loading-skeleton-radio {
  border-color: $box-border-color;
  border-radius: $box-radius;
}

{# /* // Spinner */ #}

.round-spinner {
  border-color: $primary-brand-color;
  border-left-color: darken($primary-brand-color, 5%);
  
  &:after {
    border-color: $primary-brand-color;
    border-left-color: darken($primary-brand-color, 5%);
  }
}

.spinner > .spinner-elem {
  background: $primary-brand-color;
}

.spinner-inverted > .spinner-elem {
  background: $background-color;
}

{# /* // Sign Up */ #}

.signup {
  border: 1px solid $box-border-color; 
  padding: 25px 0;
  @media (min-width: $md) {
    padding: 40px 0;
  }
}

.signup-icon {
  svg {
    fill: $primary-brand-color;
  }
}

{# /* // Modal */ #}

.modal {
  &-dialog {
    background: $background-color;
  }
}

@media (max-width: $xs) {
  .modal-xs {
    background: $background-color;
  }
}

{# /* // List */ #}

.list-group-item {
  border-color: $box-border-color;
}

{# /* // Announcement */ #}

.announcement {
  color: darken($primary-brand-color, 10%);

  &-bg {
    background: $primary-brand-color;
    box-shadow: 0px 3px 5px -1px rgba(darken($primary-brand-color, 20%), 0.35);
    border-radius: $box-radius;
  }

  &-close {
    color: $primary-brand-color;
  }
}

{%  endif %}

{%  endif %}
