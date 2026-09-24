// ignore_for_file: constant_identifier_names
//
// Usage: LocaleKeys.auth_login.tr()

abstract class LocaleKeys {
  // ─── App ─────────────────────────────────────────────────────────────────
  static const String app_name = 'app_name';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String auth_login = 'auth.login';
  static const String auth_register = 'auth.register';
  static const String auth_email = 'auth.email';
  static const String auth_password = 'auth.password';
  static const String auth_dontHaveAccount = 'auth.dont_have_account';
  static const String auth_alreadyHaveAccount = 'auth.already_have_account';
  static const String auth_or = 'auth.or';
  static const String auth_continueAsGuest = 'auth.continue_as_guest';
  static const String auth_registerSubtitle = 'auth.register_subtitle';
  static const String auth_phone = 'auth.phone';
  static const String auth_name = 'auth.name';
  static const String auth_signIn = 'auth.sign_in';
  static const String auth_welcome_back = 'auth.welcome_back';
  static const String login_subtitle = 'auth.login_subtitle';
  static const String auth_phone_or_email = 'auth.phone_or_email';
  static const String enter_password = 'auth.enter_password';
  static const String forgot_your_password = 'auth.forgot_your_password';
  static const String register_now = 'auth.register_now';
  static const String guest = 'auth.guest';
  static const String explore_account = 'auth.explore_account';
  static const String auth_namePlaceholder = 'auth.name_placeholder';
  static const String auth_phonePlaceholder = 'auth.phone_placeholder';
  static const String auth_emailPlaceholder = 'auth.email_placeholder';
  static const String auth_passwordPlaceholder = 'auth.password_placeholder';
  static const String auth_createAccountButton = 'auth.create_account_button';
  static const String auth_termsAgreePrefix = 'auth.terms_agree_prefix';
  static const String auth_termsOfService = 'auth.terms_of_service';
  static const String auth_termsAnd = 'auth.terms_and';
  static const String auth_privacyPolicy = 'auth.privacy_policy';

  // ─── OTP ──────────────────────────────────────────────────────────────────
  static const String otp_title = 'otp.title';
  static const String otp_heading = 'otp.heading';
  static const String otp_subtitle = 'otp.subtitle';
  static const String otp_verify = 'otp.verify';
  static const String otp_resendPrefix = 'otp.resend_prefix';
  static const String otp_resendSuffix = 'otp.resend_suffix';
  static const String otp_resendAction = 'otp.resend_action';
  static const String otp_changePhone = 'otp.change_phone';
  static const String otp_enterFullCode = 'otp.enter_full_code';

  // ─── Common ───────────────────────────────────────────────────────────────
  static const String common_cancel = 'common.cancel';
  static const String common_delete = 'common.delete';
  static const String common_search = 'common.search';
  static const String common_retry = 'common.retry';
  static const String common_confirm = 'common.confirm';
  static const String common_comingSoon = 'common.coming_soon';

  // ─── Validation ───────────────────────────────────────────────────────────
  static const String validation_required = 'validation.required';
  static const String validation_invalidEmail = 'validation.invalid_email';
  static const String validation_shortPassword = 'validation.short_password';
  static const String validation_invalidPhone = 'validation.invalid_phone';

  // ─── Onboarding ───────────────────────────────────────────────────────────
  static const String onboarding_skip = 'onboarding.skip';
  static const String onboarding_next = 'onboarding.next';
  static const String onboarding_getStarted = 'onboarding.get_started';
  static const String onboarding_authHaveAccount =
      'onboarding.auth_haveAccount';
  static const String onboarding_slide1_title =
      'onboarding.onboarding_slide1_title';
  static const String onboarding_slide1_subtitle =
      'onboarding.onboarding_slide1_subtitle';
  static const String onboarding_slide1_desc = 'onboarding.slide1_desc';
  static const String onboarding_slide2_title =
      'onboarding.onboarding_slide2_title';
  static const String onboarding_slide2_subtitle =
      'onboarding.onboarding_slide2_subtitle';
  static const String onboarding_slide2_desc = 'onboarding.slide2_desc';
  static const String onboarding_slide3_title =
      'onboarding.onboarding_slide3_title';
  static const String onboarding_slide3_subtitle =
      'onboarding.onboarding_slide3_subtitle';
  static const String onboarding_slide3_desc = 'onboarding.slide3_desc';

  // ─── Role ─────────────────────────────────────────────────────────────────
  static const String role_title = 'role.title';
  static const String role_subTitle = 'role.subTitle';
  static const String role_personalTitle = 'role.role_personalTitle';
  static const String role_personalDesc = 'role.role_personalDesc';
  static const String role_teamTitle = 'role.role_teamTitle';
  static const String role_teamDesc = 'role.role_teamDesc';
  static const String role_footerHint = 'role.role_footerHint';
  static const String role_continueCta = 'role.role_continueCta';

  // ─── Profile Type ─────────────────────────────────────────────────────────────────
  static const String profile_type_title = 'profile_type.title';
  static const String profile_type_subTitle = 'profile_type.subTitle';
  static const String profile_type_footerHint = 'profile_type.footerHint';
  static const String profile_type_work_title = 'profile_type.work_title';
  static const String profile_type_work_subtitle = 'profile_type.work_subtitle';
  static const String profile_type_personal_title =
      'profile_type.personal_title';
  static const String profile_type_personal_subtitle =
      'profile_type.personal_subtitle';
  static const String profile_type_freelancer_title =
      'profile_type.freelancer_title';
  static const String profile_type_freelancer_subtitle =
      'profile_type.freelancer_subtitle';
  static const String profile_type_app_bar_title_basic_info =
      'profile_type.app_bar_title_basic_info';
  static const String profile_type_basic_info_title =
      'profile_type.basic_info_title';
  static const String profile_type_basic_info_subtitle =
      'profile_type.basic_info_subtitle';
  static const String profile_type_basic_info_photo_label =
      'profile_type.basic_info_photo_label';
  static const String profile_type_basic_info_photo_hint =
      'profile_type.basic_info_photo_hint';
  static const String profile_type_basic_info_choose_photo =
      'profile_type.basic_info_choose_photo';
  static const String profile_type_basic_info_photo_camera =
      'profile_type.basic_info_photo_camera';
  static const String profile_type_basic_info_photo_gallery =
      'profile_type.basic_info_photo_gallery';
  static const String profile_type_basic_info_photo_pick_error =
      'profile_type.basic_info_photo_pick_error';
  static const String profile_type_basic_info_full_name =
      'profile_type.basic_info_full_name';
  static const String profile_type_basic_info_full_name_hint =
      'profile_type.basic_info_full_name_hint';
  static const String profile_type_basic_info_job_title =
      'profile_type.basic_info_job_title';
  static const String profile_type_basic_info_job_title_hint =
      'profile_type.basic_info_job_title_hint';
  static const String profile_type_basic_info_company =
      'profile_type.basic_info_company';
  static const String profile_type_basic_info_company_hint =
      'profile_type.basic_info_company_hint';
  static const String profile_type_basic_info_bio =
      'profile_type.basic_info_bio';
  static const String profile_type_basic_info_bio_hint =
      'profile_type.basic_info_bio_hint';
  static const String profile_type_basic_info_phone =
      'profile_type.basic_info_phone';
  static const String profile_type_basic_info_phone_hint =
      'profile_type.basic_info_phone_hint';
  static const String profile_type_basic_info_saved_snackbar =
      'profile_type.basic_info_saved_snackbar';
  static const String profile_type_basic_info_required_error =
      'profile_type.basic_info_required_error';
  static const String profile_type_location = 'profile_type.location';
  static const String profile_type_city = 'profile_type.city';

  // ─── Contact Channels (profile completion step 3) ──────────────────────────
  static const String channels_title = 'channels.title';
  static const String channels_subtitle = 'channels.subtitle';
  static const String channels_whatsapp = 'channels.whatsapp';
  static const String channels_whatsappHint = 'channels.whatsapp_hint';
  static const String channels_linkedin = 'channels.linkedin';
  static const String channels_linkedinHint = 'channels.linkedin_hint';
  static const String channels_instagram = 'channels.instagram';
  static const String channels_instagramHint = 'channels.instagram_hint';
  static const String channels_x = 'channels.x';
  static const String channels_xHint = 'channels.x_hint';
  static const String channels_snapchat = 'channels.snapchat';
  static const String channels_snapchatHint = 'channels.snapchat_hint';
  static const String channels_tiktok = 'channels.tiktok';
  static const String channels_tiktokHint = 'channels.tiktok_hint';

  // ─── Contact Links (profile completion step 4) ─────────────────────────────
  static const String links_title = 'links.title';
  static const String links_subtitle = 'links.subtitle';
  static const String links_website = 'links.website';
  static const String links_websiteHint = 'links.website_hint';
  static const String links_portfolio = 'links.portfolio';
  static const String links_portfolioHint = 'links.portfolio_hint';
  static const String links_booking = 'links.booking';
  static const String links_bookingHint = 'links.booking_hint';
  static const String links_quote = 'links.quote';
  static const String links_quoteHint = 'links.quote_hint';
  static const String links_brochure = 'links.brochure';
  static const String links_brochureHint = 'links.brochure_hint';
  static const String links_customLink = 'links.custom_link';
  static const String links_customLinkHint = 'links.custom_link_hint';

  // ─── Products & Services (profile completion step 5) ───────────────────────
  static const String products_title = 'products.title';
  static const String products_subtitle = 'products.subtitle';
  static const String products_enableTitle = 'products.enable_title';
  static const String products_enableSubtitle = 'products.enable_subtitle';
  static const String products_countLabel = 'products.count_label';
  static const String products_serviceCountLabel =
      'products.service_count_label';
  static const String products_addProduct = 'products.add_product';
  static const String products_addTitle = 'products.add_title';
  static const String products_editTitle = 'products.edit_title';
  static const String products_addServiceTitle = 'products.add_service_title';
  static const String products_editServiceTitle = 'products.edit_service_title';
  static const String products_nameLabel = 'products.name_label';
  static const String products_nameHint = 'products.name_hint';
  static const String products_priceLabel = 'products.price_label';
  static const String products_priceHint = 'products.price_hint';
  static const String products_emptyHint = 'products.empty_hint';
  static const String products_itemSaved = 'products.item_saved';
  static const String products_kindLabel = 'products.kind_label';
  static const String products_kindProduct = 'products.kind_product';
  static const String products_kindService = 'products.kind_service';
  static const String products_descriptionLabel = 'products.description_label';
  static const String products_descriptionHint = 'products.description_hint';
  static const String products_pricePrefixLabel = 'products.price_prefix_label';
  static const String products_pricePrefixHint = 'products.price_prefix_hint';
  static const String products_actionTypeLabel = 'products.action_type_label';
  static const String products_actionUrlLabel = 'products.action_url_label';
  static const String products_actionUrlHint = 'products.action_url_hint';
  static const String products_imageLabel = 'products.image_label';
  static const String products_changeImage = 'products.change_image';
  static const String products_addImage = 'products.add_image';
  static const String products_removeImage = 'products.remove_image';
  static const String products_previewLabel = 'products.preview_label';
  static const String products_deleteConfirmTitle =
      'products.delete_confirm_title';
  static const String products_deleteConfirmMessage =
      'products.delete_confirm_message';

  // ─── Content Ranking (profile completion step 6) ───────────────────────────
  static const String ranking_title = 'ranking.title';
  static const String ranking_subtitle = 'ranking.subtitle';
  static const String ranking_basicInfo = 'ranking.basic_info';
  static const String ranking_basicInfoPinned = 'ranking.basic_info_pinned';
  static const String ranking_bio = 'ranking.bio';
  static const String ranking_quickContact = 'ranking.quick_contact';
  static const String ranking_channels = 'ranking.channels';
  static const String ranking_links = 'ranking.links';
  static const String ranking_products = 'ranking.products';
  static const String ranking_services = 'ranking.services';
  static const String ranking_dragHint = 'ranking.drag_hint';

  // ─── Template (profile completion step 7) ──────────────────────────────────
  static const String template_title = 'template.title';
  static const String template_subtitle = 'template.subtitle';
  static const String template_simpleTitle = 'template.simple_title';
  static const String template_simpleSubtitle = 'template.simple_subtitle';
  static const String template_professionalTitle =
      'template.professional_title';
  static const String template_professionalSubtitle =
      'template.professional_subtitle';
  static const String template_personalTitle = 'template.personal_title';
  static const String template_personalSubtitle = 'template.personal_subtitle';
  static const String template_freeBadge = 'template.free_badge';
  static const String template_paidBadge = 'template.paid_badge';

  // ─── Appearance (profile completion step 8) ────────────────────────────────
  static const String appearance_title = 'appearance.title';
  static const String appearance_primaryColor = 'appearance.primary_color';
  static const String appearance_coverColor = 'appearance.cover_color';
  static const String appearance_profileBackground =
      'appearance.profile_background';
  static const String appearance_backgroundGradient =
      'appearance.background_gradient';
  static const String appearance_backgroundLight =
      'appearance.background_light';
  static const String appearance_backgroundWhite =
      'appearance.background_white';
  static const String appearance_previewCall = 'appearance.preview_call';
  static const String appearance_previewWhatsapp =
      'appearance.preview_whatsapp';
  static const String appearance_elementShape = 'appearance.element_shape';
  static const String appearance_shapeSquare = 'appearance.shape_square';
  static const String appearance_shapeCurved = 'appearance.shape_curved';
  static const String appearance_shapeRounded = 'appearance.shape_rounded';
  static const String appearance_fontStyle = 'appearance.font_style';
  static const String appearance_fontTajawal = 'appearance.font_tajawal';
  static const String appearance_fontCairo = 'appearance.font_cairo';
  static const String appearance_fontAlmarai = 'appearance.font_almarai';
  static const String appearance_fontSample = 'appearance.font_sample';
  static const String appearance_previewProfile = 'appearance.preview_profile';

  // ─── Publish & Preview (profile completion) ─────────────────────────
  static const String publish_saveAndPublish = 'publish.save_and_publish';
  static const String publish_previewEditor = 'publish.preview_editor';
  static const String publish_finish = 'publish.finish';
  static const String publish_viewAsVisitor = 'publish.view_as_visitor';
  static const String publish_copyLink = 'publish.copy_link';
  static const String publish_linkCopied = 'publish.link_copied';
  static const String publish_saveContact = 'publish.save_contact';
  static const String publish_viewAll = 'publish.view_all';
  static const String publish_shareCta = 'publish.share_cta';
  static const String publish_publishedSuccess = 'publish.published_success';
  static const String publish_publishCard = 'publish.publish_card';
  static const String publish_cardCompany = 'publish.card_company';
  static const String publish_linkYourCard = 'publish.link_your_card';
  static const String publish_enterHandle = 'publish.enter_handle';
  static const String publish_showToPublic = 'publish.show_to_public';
  static const String publish_showToPublicHint = 'publish.show_to_public_hint';
  static const String common_somethingWentWrong = 'common.something_went_wrong';
  static const String publish_publishedTitle = 'publish.publishedTitle';
  static const String publish_viewCard = 'publish.viewCard';
  static const String publish_publishedSuccessTitle =
      'publish.publishedSuccessTitle';
  static const String publish_publishedSuccessSubtitle =
      'publish.publishedSuccessSubtitle';
  static const String publish_copy = 'publish.copy';
  static const String publish_myCards = 'publish.myCards';
  static const String publish_qrCode = 'publish.qrCode';
  static const String publish_share = 'publish.share';
  static const String publish_aboutMe = 'publish.aboutMe';
  static const String publish_cardEmail = 'publish.cardEmail';
  static const String publish_whatsapp = 'publish.whatsapp';
  static const String publish_call = 'publish.call';
  static const String publish_productsAndServices =
      'publish.productsAndServices';
  static const String publish_exitPreview = 'publish.exitPreview';
  static const String publish_contactMe = 'publish.contactMe';
  static const String publish_contactLinks = 'publish.contactLinks';
  static const String publish_share_data = 'publish.share_data';
  static const String publish_made_with = 'publish.made_with';
  static const String publish_file_sharing = 'publish.file_sharing';

  // ─── QR ─────────────────────────────────────────────────────────────────
  static const String qr_title = 'qr.title';
  static const String qr_simulateScan = 'qr.simulateScan';
  static const String qr_downloadQr = 'qr.downloadQr';
  static const String qr_howToShareTitle = 'qr.howToShareTitle';
  static const String qr_howToShareSubtitle = 'qr.howToShareSubtitle';
  static const String qr_howToShareStepCamera = 'qr.howToShareStepCamera';
  static const String qr_howToShareStepLink = 'qr.howToShareStepLink';
  static const String qr_howToShareStepBrowser = 'qr.howToShareStepBrowser';
  static const String qr_publishedAndActive = 'qr.publishedAndActive';

  // ─── Navigation ───────────────────────────────────────────────────────────
  static const String nav_home = 'nav.home';
  static const String nav_more = 'nav.more';
  static const String nav_files = 'nav.my_files';
  static const String nav_clients = 'nav.clients';
  static const String nav_account = 'nav.account';

  // ─── Home ─────────────────────────────────────────────────────────────────
  static const String home_welcome = 'home.welcome';
  static const String home_greeting = 'home.greeting';
  static const String home_active_badge = 'home.active_badge';
  static const String home_stat_conversion = 'home.stat_conversion';
  static const String home_stat_potential_clients =
      'home.stat_potential_clients';
  static const String home_stat_visits = 'home.stat_visits';
  static const String home_edit_profile = 'home.edit_profile';
  static const String home_action_stats = 'home.action_stats';
  static const String home_action_share = 'home.action_share';
  static const String home_action_preview = 'home.action_preview';
  static const String home_completion_title = 'home.completion_title';
  static const String home_complete_profile_badge =
      'home.complete_profile_badge';
  static const String home_complete_profile_hint = 'home.complete_profile_hint';
  static const String home_my_cards_title = 'home.my_cards_title';
  static const String home_card_not_published_title =
      'home.card_not_published_title';
  static const String home_card_not_published_subtitle =
      'home.card_not_published_subtitle';
  static const String home_complete_and_publish = 'home.complete_and_publish';
  static const String home_store_badge_new = 'home.store_badge_new';
  static const String home_store_title = 'home.store_title';
  static const String home_store_subtitle = 'home.store_subtitle';
  static const String home_recent_activities_title =
      'home.recent_activities_title';
  static const String home_view_all = 'home.view_all';
  static const String home_activity_profile_visit =
      'home.activity_profile_visit';
  static const String home_activity_link_interaction =
      'home.activity_link_interaction';
  static const String home_activity_contact_saved =
      'home.activity_contact_saved';
  static const String home_hours_ago = 'home.hours_ago';
  static const String home_potential_clients_title =
      'home.potential_clients_title';
  static const String home_build_client_list_title =
      'home.build_client_list_title';
  static const String home_build_client_list_subtitle =
      'home.build_client_list_subtitle';
  static const String home_start_creating_profile =
      'home.start_creating_profile';
  static const String home_published_badge = 'home.published_badge';

  // ––– Store ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
  static const String store_title = 'store.title';
  static const String store_offers = 'store.offers';
  static const String store_special_offer = 'store.special_offer';
  static const String store_featured_products = 'store.featured_products';
  static const String store_view_all = 'store.view_all';
  static const String store_view_all_count = 'store.view_all_count';
  static const String store_search_hint = 'store.search_hint';
  static const String store_products_title = 'store.products_title';
  static const String store_product_count = 'store.product_count';
  static const String store_empty_products = 'store.empty_products';
  static const String store_category_all = 'store.category_all';
  static const String store_category_nfc = 'store.category_nfc';
  static const String store_category_metal = 'store.category_metal';
  static const String store_category_stickers = 'store.category_stickers';
  static const String store_color = 'store.color';
  static const String store_quantity = 'store.quantity';
  static const String store_compatibility = 'store.compatibility';
  static const String store_delivery = 'store.delivery';
  static const String store_package_contents = 'store.package_contents';
  static const String store_customize = 'store.customize';
  static const String store_add_to_cart = 'store.add_to_cart';
  static const String store_added_to_cart = 'store.added_to_cart';
  static const String store_badge_best_seller = 'store.badge_best_seller';
  static const String store_customizable = 'store.customizable';
  static const String store_sort_featured = 'store.sort_featured';
  static const String store_sort_most_ordered = 'store.sort_most_ordered';
  static const String store_sort_price_low = 'store.sort_price_low';
  static const String store_sort_price_high = 'store.sort_price_high';
  static const String store_total = 'store.total';
  static const String store_currency = 'store.currency';
  static const String store_shipping_fee = 'store.shipping_fee';
  static const String store_free_shipping_over = 'store.free_shipping_over';
  static const String store_color_black = 'store.color_black';
  static const String store_color_white = 'store.color_white';
  static const String store_color_gold = 'store.color_gold';
  static const String store_color_silver = 'store.color_silver';
  static const String store_color_blue = 'store.color_blue';
  static const String store_color_green = 'store.color_green';
  static const String store_cart_title = 'store.cart_title';
  static const String store_cart_empty = 'store.cart_empty';
  static const String store_cart_empty_hint = 'store.cart_empty_hint';
  static const String store_continue_shopping = 'store.continue_shopping';
  static const String store_order_summary = 'store.order_summary';
  static const String store_subtotal = 'store.subtotal';
  static const String store_shipping = 'store.shipping';
  static const String store_free_shipping = 'store.free_shipping';
  static const String store_shipping_at_checkout = 'store.shipping_at_checkout';
  static const String store_proceed_to_checkout = 'store.proceed_to_checkout';
  static const String store_remove_item = 'store.remove_item';
  static const String store_checkout_title = 'store.checkout_title';
  static const String store_shipping_address = 'store.shipping_address';
  static const String store_full_name = 'store.full_name';
  static const String store_phone_number = 'store.phone_number';
  static const String store_address = 'store.address';
  static const String store_location = 'store.location';
  static const String store_city = 'store.city';
  static const String store_district = 'store.district';
  static const String store_street = 'store.street';
  static const String store_extra_details = 'store.extra_details';
  static const String store_save_address = 'store.save_address';
  static const String store_delivery_note = 'store.delivery_note';
  static const String store_delivery_days = 'store.delivery_days';
  static const String store_continue_to_payment = 'store.continue_to_payment';
  static const String store_payment_title = 'store.payment_title';
  static const String store_payment_method = 'store.payment_method';
  static const String store_credit_card = 'store.credit_card';
  static const String store_cash_on_delivery = 'store.cash_on_delivery';
  static const String store_card_number = 'store.card_number';
  static const String store_expiry_date = 'store.expiry_date';
  static const String store_cvv = 'store.cvv';
  static const String store_secure_payment_note = 'store.secure_payment_note';
  static const String store_confirm_order = 'store.confirm_order';
  static const String store_order_confirmed = 'store.order_confirmed';
  static const String store_order_confirmed_hint = 'store.order_confirmed_hint';
  static const String store_order_number = 'store.order_number';
  static const String store_copy = 'store.copy';
  static const String store_order_copied = 'store.order_copied';
  static const String store_order_date = 'store.order_date';
  static const String store_back_to_home = 'store.back_to_home';
  static const String store_customization_title = 'store.customization_title';
  static const String store_live_preview = 'store.live_preview';
  static const String store_card_text = 'store.card_text';
  static const String store_job_title = 'store.job_title';
  static const String store_company_name = 'store.company_name';
  static const String store_notes = 'store.notes';
  static const String store_font_type = 'store.font_type';
  static const String store_card_tools = 'store.card_tools';
  static const String store_upload_logo = 'store.upload_logo';
  static const String store_card_color = 'store.card_color';
  static const String store_choose_font = 'store.choose_font';
  static const String store_current_logo = 'store.current_logo';
  static const String store_approve_design = 'store.approve_design';
  static const String store_font_tajawal = 'store.font_tajawal';
  static const String store_font_cairo = 'store.font_cairo';
  static const String store_error_required = 'store.error_required';
  static const String store_error_phone_invalid = 'store.error_phone_invalid';
  static const String store_error_card_invalid = 'store.error_card_invalid';
  static const String store_error_expiry_invalid = 'store.error_expiry_invalid';
  static const String store_error_cvv_invalid = 'store.error_cvv_invalid';

  // ─── My Cards ───────────────────────────────────────────────────────────
  static const String myCards_edit = 'my_cards.edit';
  static const String myCards_preview = 'my_cards.preview';
  static const String myCards_qr = 'my_cards.qr';
  static const String myCards_more = 'my_cards.more';
  static const String myCards_statusActive = 'my_cards.statusActive';
  static const String myCards_statusDraft = 'my_cards.statusDraft';
  static const String myCards_statusPaused = 'my_cards.statusPaused';
  static const String myCards_isPublished = 'my_cards.isPublished';
  static const String myCards_notPublished = 'my_cards.notPublished';
  static const String myCards_hasNfc = 'my_cards.hasNfc';
  static const String myCards_createNewCard = 'my_cards.createNewCard';
  static const String myCards_duplicate = 'my_cards.duplicate';
  static const String myCards_rename = 'my_cards.rename';
  static const String myCards_pause = 'my_cards.pause';
  static const String myCards_activate = 'my_cards.activate';
  static const String myCards_delete = 'my_cards.delete';
  static const String myCards_clientsCount = 'my_cards.clientsCount';
  static const String myCards_visitsCount = 'my_cards.visitsCount';
  static const String myCards_categoryBusiness = 'my_cards.categoryBusiness';
  static const String myCards_categoryPersonal = 'my_cards.categoryPersonal';
  static const String myCards_categoryFreelancer =
      'my_cards.categoryFreelancer';
  static const String myCards_detailsTitle = 'my_cards.detailsTitle';
  static const String myCards_share = 'my_cards.share';
  static const String myCards_publishStatus = 'my_cards.publishStatus';
  static const String myCards_nfcPremium = 'my_cards.nfcPremium';
  static const String myCards_nfcEnabled = 'my_cards.nfcEnabled';
  static const String myCards_nfcDisabled = 'my_cards.nfcDisabled';
  static const String myCards_statsVisits = 'my_cards.statsVisits';
  static const String myCards_statsClients = 'my_cards.statsClients';
  static const String myCards_statsLastUpdate = 'my_cards.statsLastUpdate';
  static const String myCards_createdAt = 'my_cards.createdAt';
  static const String myCards_isDefault = 'my_cards.isDefault';
  static const String myCards_viewClients = 'my_cards.viewClients';
  static const String myCards_link = 'my_cards.link';

  // ─── Company ────────────────────────────────────────────────────────────
  static const String company_header = 'company.header';
  static const String company_title = 'company.title';
  static const String company_next = 'company.next';
  static const String company_back = 'company.back';
  static const String company_finish = 'company.finish';
  static const String company_retry = 'company.retry';
  static const String company_basic_subtitle = 'company.basic_subtitle';
  static const String company_name = 'company.name';
  static const String company_name_hint = 'company.name_hint';
  static const String company_bio = 'company.bio';
  static const String company_bio_hint = 'company.bio_hint';
  static const String company_industry = 'company.industry';
  static const String company_sub_industry = 'company.sub_industry';
  static const String company_sub_industry_empty =
      'company.sub_industry_empty';
  static const String company_city = 'company.city';
  static const String company_city_hint = 'company.city_hint';
  static const String company_size = 'company.size';
  static const String company_email = 'company.email';
  static const String company_email_hint = 'company.email_hint';
  static const String company_phone = 'company.phone';
  static const String company_phone_hint = 'company.phone_hint';
  static const String company_website = 'company.website';
  static const String company_website_hint = 'company.website_hint';
  static const String company_review_title = 'company.review_title';
  static const String company_review_subtitle = 'company.review_subtitle';
  static const String company_error_required = 'company.error_required';
  static const String company_error_email = 'company.error_email';
  static const String company_error_submit = 'company.error_submit';
  static const String company_success_title = 'company.success_title';
  static const String company_success_subtitle = 'company.success_subtitle';
  static const String company_go_dashboard = 'company.go_dashboard';
  static const String company_dashboard_title = 'company.dashboard_title';
  static const String company_dashboard_sub = 'company.dashboard_sub';
  static const String company_complete_profile = 'company.complete_profile';
  static const String company_complete_hint = 'company.complete_hint';
  static const String company_settings = 'company.settings';
  static const String company_cards = 'company.cards';
  static const String company_brand = 'company.brand';
  static const String company_catalog = 'company.catalog';
  static const String company_employees = 'company.employees';
  static const String company_qr = 'company.qr';
  static const String company_qr_page_title = 'company.qr_page_title';
  static const String company_qr_page_subtitle = 'company.qr_page_subtitle';
  static const String company_qr_simulate_scan = 'company.qr_simulate_scan';
  static const String company_qr_share_link = 'company.qr_share_link';
  static const String company_publish = 'company.publish';
  static const String company_edit = 'company.edit';
  static const String company_active_employees = 'company.active_employees';
  static const String company_active_cards = 'company.active_cards';
  static const String company_visits = 'company.visits';
  static const String company_leads = 'company.leads';
  static const String company_public_page = 'company.public_page';
  static const String company_public_page_hint = 'company.public_page_hint';
  static const String company_view_page = 'company.view_page';
  static const String company_publish_page = 'company.publish_page';
  static const String company_setup_catalog = 'company.setup_catalog';
  static const String company_back_to_personal = 'company.back_to_personal';
  static const String company_quick_procedures = 'company.quick_procedures';
  static const String company_fans = 'company.fans';
  static const String company_setup_title = 'company.setup_title';
  static const String company_continue = 'company.continue';
  static const String company_create_company = 'company.create_company';
  static const String company_step1_subtitle = 'company.step1_subtitle';
  static const String company_step1_title = 'company.step1_title';
  static const String company_step2_title = 'company.step2_title';
  static const String company_step2_subtitle = 'company.step2_subtitle';
  static const String company_step3_title = 'company.step3_title';
  static const String company_step3_subtitle = 'company.step3_subtitle';
  static const String company_step4_title = 'company.step4_title';
  static const String company_step4_subtitle = 'company.step4_subtitle';
<<<<<<< HEAD
  static const String company_step5_title = 'company.step5_title';
  static const String company_step5_subtitle = 'company.step5_subtitle';
  static const String company_image_label = 'company.image_label';
  static const String company_image_hint = 'company.image_hint';
  static const String company_upload_image = 'company.upload_image';
=======
>>>>>>> 0ecc604e79f8296123f1d0d807b0097f196b95cd
  static const String company_logo_hint = 'company.logo_hint';
  static const String company_contact_email = 'company.contact_email';
<<<<<<< HEAD
  static const String company_nature_food = 'company.nature_food';
  static const String company_nature_retail = 'company.nature_retail';
  static const String company_nature_services = 'company.nature_services';
  static const String company_nature_other = 'company.nature_other';
  static const String company_cards_page_title = 'company.cards_page_title';
  static const String company_card_numbered = 'company.card_numbered';
  static const String company_card_deactivated = 'company.card_deactivated';
  static const String company_stat_total = 'company.stat_total';
  static const String company_stat_available = 'company.stat_available';
  static const String company_stat_active = 'company.stat_active';
  static const String company_stat_disabled = 'company.stat_disabled';
  static const String company_filter_all = 'company.filter_all';
  static const String company_filter_active_short =
      'company.filter_active_short';
  static const String company_filter_pending = 'company.filter_pending';
  static const String company_filter_suspended = 'company.filter_suspended';
  static const String company_status_available = 'company.status_available';
  static const String company_status_active = 'company.status_active';
  static const String company_status_active_feminine =
      'company.status_active_feminine';
  static const String company_status_disabled = 'company.status_disabled';
  static const String company_cards_empty = 'company.cards_empty';
  static const String company_cards_empty_desc = 'company.cards_empty_desc';
  static const String company_activate = 'company.activate';
  static const String company_deactivate = 'company.deactivate';
  static const String company_card_activated = 'company.card_activated';
  static const String company_brand_identity_title =
      'company.brand_identity_title';
  static const String company_brand_hint = 'company.brand_hint';
  static const String company_preview = 'company.preview';
  static const String company_primary_color = 'company.primary_color';
  static const String company_profile_template = 'company.profile_template';
  static const String company_template_simple = 'company.template_simple';
  static const String company_template_pro = 'company.template_pro';
  static const String company_template_personal = 'company.template_personal';
  static const String company_tagline = 'company.tagline';
  static const String company_tagline_hint = 'company.tagline_hint';
  static const String company_lock_colors = 'company.lock_colors';
  static const String company_lock_colors_hint = 'company.lock_colors_hint';
  static const String company_save = 'company.save';
  static const String company_save_brand = 'company.save_brand';
  static const String company_brand_saved = 'company.brand_saved';
  static const String company_bio_default = 'company.company_bio_default';
  static const String company_edit_data_title = 'company.edit_data_title';
  static const String company_name_label = 'company.name_label';
  static const String company_bio_label = 'company.bio_label';
  static const String company_website_label = 'company.website_label';
  static const String company_business_type_label =
      'company.business_type_label';
  static const String company_industry_label = 'company.industry_label';
  static const String company_size_label = 'company.size_label';
  static const String company_city_label = 'company.city_label';
  static const String company_phone_contact = 'company.phone_contact';
  static const String company_email_official = 'company.email_official';
  static const String company_save_changes = 'company.save_changes';
  static const String company_name_required = 'company.name_required';
  static const String company_saved = 'company.company_saved';
  static const String company_type_general = 'company.type_general';
  static const String company_type_general_desc = 'company.type_general_desc';
  static const String company_type_restaurant2 = 'company.type_restaurant2';
  static const String company_type_restaurant_desc =
      'company.type_restaurant_desc';
  static const String company_type_clinic2 = 'company.type_clinic2';
  static const String company_type_clinic_desc = 'company.type_clinic_desc';
  static const String company_type_retail2 = 'company.type_retail2';
  static const String company_type_retail_desc = 'company.type_retail_desc';
  static const String company_ind_professional = 'company.ind_professional';
  static const String company_ind_marketing = 'company.ind_marketing';
  static const String company_ind_retail = 'company.ind_retail';
  static const String company_ind_food = 'company.ind_food';
  static const String company_ind_real_estate = 'company.ind_real_estate';
  static const String company_ind_health = 'company.ind_health';
  static const String company_ind_education = 'company.ind_education';
  static const String company_ind_tourism = 'company.ind_tourism';
  static const String company_ind_events = 'company.ind_events';
  static const String company_ind_other = 'company.ind_other';
  static const String company_size_1_10 = 'company.size_1_10';
  static const String company_size_11_50 = 'company.size_11_50';
  static const String company_size_51_200 = 'company.size_51_200';
  static const String company_size_200_plus = 'company.size_200_plus';
  static const String company_employees_title = 'company.employees_title';
  static const String company_search_employees_hint =
      'company.search_employees_hint';
  static const String company_no_employees = 'company.no_employees';
  static const String company_no_employees_desc = 'company.no_employees_desc';
  static const String company_no_results = 'company.no_results';
  static const String company_no_results_desc = 'company.no_results_desc';
  static const String company_linked_profile = 'company.linked_profile';
  static const String company_no_profile = 'company.no_profile';
  static const String company_invite_title = 'company.invite_title';
  static const String company_invite_subtitle = 'company.invite_subtitle';
  static const String company_full_name_star = 'company.full_name_star';
  static const String company_email_star = 'company.email_star';
  static const String company_phone_number = 'company.phone_number';
  static const String company_job_title_star = 'company.job_title_star';
  static const String company_department = 'company.department';
  static const String company_department_hint = 'company.department_hint';
  static const String company_send_invite = 'company.send_invite';
  static const String company_sending_invite = 'company.sending_invite';
  static const String company_invite_sent = 'company.invite_sent';
  static const String company_invite_sent_desc = 'company.invite_sent_desc';
  static const String company_view_employees_list =
      'company.view_employees_list';
  static const String company_invite_another = 'company.invite_another';
  static const String company_employee_details_title =
      'company.employee_details_title';
  static const String company_employee_edit_title =
      'company.employee_edit_title';
  static const String company_employee_actions = 'company.employee_actions';
  static const String company_employee_edit_data = 'company.employee_edit_data';
  static const String company_employee_resend_invite =
      'company.employee_resend_invite';
  static const String company_employee_cancel_invite =
      'company.employee_cancel_invite';
  static const String company_employee_deactivate =
      'company.employee_deactivate';
  static const String company_employee_activate = 'company.employee_activate';
  static const String company_employee_link_nfc = 'company.employee_link_nfc';
  static const String company_employee_remove = 'company.employee_remove';
  static const String company_employee_not_linked =
      'company.employee_not_linked';
  static const String company_employee_nfc_card = 'company.employee_nfc_card';
  static const String company_employee_digital_title =
      'company.employee_digital_title';
  static const String company_employee_digital_desc =
      'company.employee_digital_desc';
  static const String company_employee_profile_first_title =
      'company.employee_profile_first_title';
  static const String company_employee_profile_first_desc =
      'company.employee_profile_first_desc';
  static const String company_employee_updated = 'company.employee_updated';
  static const String company_employee_invite_resent =
      'company.employee_invite_resent';
  static const String company_employee_profile_linked =
      'company.employee_profile_linked';
  static const String company_employee_nfc_linked =
      'company.employee_nfc_linked';
  static const String company_employee_removed = 'company.employee_removed';
  static const String company_employee_remove_confirm_title =
      'company.employee_remove_confirm_title';
  static const String company_employee_remove_confirm_desc =
      'company.employee_remove_confirm_desc';
  static const String company_catalog_title = 'company.catalog_title';
  static const String company_menu_title = 'company.menu_title';
  static const String company_menu_cat_drinks = 'company.menu_cat_drinks';
  static const String company_menu_cat_main = 'company.menu_cat_main';
  static const String company_menu_cat_appetizers =
      'company.menu_cat_appetizers';
  static const String company_catalog_empty = 'company.catalog_empty';
  static const String company_add_to_order = 'company.add_to_order';
  static const String company_item_details_title = 'company.item_details_title';
  static const String company_service_details_title =
      'company.service_details_title';
  static const String company_close = 'company.close';
  static const String company_price_title = 'company.price_title';
  static const String company_provided_by = 'company.provided_by';
  static const String company_order_now = 'company.order_now';
  static const String company_manage_item = 'company.manage_item';
  static const String company_item_image_url = 'company.item_image_url';
  static const String company_item_updated = 'company.item_updated';
  static const String company_hide_item = 'company.hide_item';
  static const String company_show_item = 'company.show_item';
  static const String company_cancel = 'company.cancel';
  static const String company_products_section = 'company.products_section';
  static const String company_services_section = 'company.services_section';
  static const String company_no_products = 'company.no_products';
  static const String company_no_services = 'company.no_services';
  static const String company_add_product = 'company.add_product';
  static const String company_add_service = 'company.add_service';
  static const String company_add_item_title = 'company.add_item_title';
  static const String company_edit_item_title = 'company.edit_item_title';
  static const String company_kind_product = 'company.kind_product';
  static const String company_kind_service = 'company.kind_service';
  static const String company_item_name = 'company.item_name';
  static const String company_item_name_required = 'company.item_name_required';
  static const String company_item_desc = 'company.item_desc';
  static const String company_item_desc_hint = 'company.item_desc_hint';
  static const String company_item_price = 'company.item_price';
  static const String company_item_price_label = 'company.item_price_label';
  static const String company_price_label_hint = 'company.price_label_hint';
  static const String company_no_price = 'company.no_price';
  static const String company_hidden = 'company.hidden';
  static const String company_save_item = 'company.save_item';
  static const String company_example_consult = 'company.example_consult';
  static const String company_delete_item = 'company.delete_item';
  static const String company_item_deleted = 'company.item_deleted';
  static const String company_publish_title = 'company.publish_title';
  static const String company_published_title = 'company.published_title';
  static const String company_page_published = 'company.page_published';
  static const String company_page_available = 'company.page_available';
  static const String company_what_includes = 'company.what_includes';
  static const String company_includes_company = 'company.includes_company';
  static const String company_includes_catalog = 'company.includes_catalog';
  static const String company_includes_team = 'company.includes_team';
  static const String company_includes_contact = 'company.includes_contact';
  static const String company_page_link = 'company.page_link';
  static const String company_link_hint_public = 'company.link_hint_public';
  static const String company_publishing = 'company.publishing';
  static const String company_view_public_page = 'company.view_public_page';
  static const String company_share_label = 'company.share_label';
  static const String company_employee_word = 'company.employee_word';
  static const String company_add_contact = 'company.add_contact';
  static const String company_website_short = 'company.website_short';
  static const String company_team = 'company.team';
  static const String company_share_page = 'company.share_page';
  static const String company_powered_by = 'company.powered_by';
  static const String company_nfc_page_title = 'company.nfc_page_title';
  static const String company_nfc_intro_title = 'company.nfc_intro_title';
  static const String company_nfc_intro_desc = 'company.nfc_intro_desc';
  static const String company_nfc_req1 = 'company.nfc_req1';
  static const String company_nfc_req2 = 'company.nfc_req2';
  static const String company_enter_serial = 'company.enter_serial';
  static const String company_scan_serial_qr = 'company.scan_serial_qr';
  static const String company_serial_label = 'company.serial_label';
  static const String company_serial_hint = 'company.serial_hint';
  static const String company_serial_placeholder = 'company.serial_placeholder';
  static const String company_serial_error = 'company.serial_error';
  static const String company_verify_serial = 'company.verify_serial';
  static const String company_verifying = 'company.verifying';
  static const String company_verifying_desc = 'company.verifying_desc';
  static const String company_select_profile = 'company.select_profile';
  static const String company_confirm_activation = 'company.confirm_activation';
  static const String company_product_label = 'company.product_label';
  static const String company_linked_profile_label =
      'company.linked_profile_label';
  static const String company_activate_button = 'company.activate_button';
  static const String company_activating = 'company.activating';
  static const String company_activating_desc = 'company.activating_desc';
  static const String company_activation_done = 'company.activation_done';
  static const String company_activation_done_desc =
      'company.activation_done_desc';
  static const String company_nfc_product_name = 'company.nfc_product_name';
  static const String company_status_active_short =
      'company.status_active_short';
  static const String company_activation_date = 'company.activation_date';
  static const String company_back_home = 'company.back_home';
  static const String company_back_button = 'company.back_button';
  static const String company_copy = 'company.copy';
  static const String company_my_profile_fallback =
      'company.my_profile_fallback';
=======
>>>>>>> 0ecc604e79f8296123f1d0d807b0097f196b95cd

  // ─── Splash ───────────────────────────────────────────────────────────────
  static const String splash_subtitle = 'splash.subtitle';
  static const String splash_loading = 'splash.loading';

  // ─── More ─────────────────────────────────────────────────────────────────
  static const String more_title = 'more.title';
  static const String more_profileCardSubtitle = 'more.profile_card_subtitle';

  // ─── Profile ──────────────────────────────────────────────────────────────
  static const String profile_title = 'profile.title';
  static const String profile_loginNow = 'profile.login_now';

  // ─── Settings ─────────────────────────────────────────────────────────────
  static const String settings_changeLanguage = 'settings.change_language';
  static const String settings_changeLanguageSubtitle =
      'settings.change_language_subtitle';
  static const String settings_languageTitle = 'settings.language_title';
  static const String settings_arabic = 'settings.arabic';
  static const String settings_english = 'settings.english';
  static const String settings_logout = 'settings.logout';
  static const String settings_logoutSubtitle = 'settings.logout_subtitle';
  static const String settings_logoutDialogTitle =
      'settings.logout_dialog_title';
  static const String settings_logoutDialogMessage =
      'settings.logout_dialog_message';

  // ─── App Bar ─────────────────────────────────────────────────────────────────
  static const String app_bar_back = 'app_bar.back';
  static const String app_bar_step = 'app_bar.step';

  // ─── Errors ───────────────────────────────────────────────────────────────
  static const String error_unauthorized = 'error.unauthorized';
  static const String error_notFound = 'error.not_found';

  // ─── Statistics ─────────────────────────────────────────────────────────────
  static const String stats_title = 'stats.title';
  static const String stats_summary_title = 'stats.summary_title';
  static const String stats_total_visits = 'stats.total_visits';
  static const String stats_unique_visitors = 'stats.unique_visitors';
  static const String stats_contact_saved = 'stats.contact_saved';
  static const String stats_potential_clients = 'stats.potential_clients';
  static const String stats_conversion_rate = 'stats.conversion_rate';
  static const String stats_visit_sources = 'stats.visit_sources';
  static const String stats_link_interaction = 'stats.link_interaction';
  static const String stats_source_nfc = 'stats.source_nfc';
  static const String stats_source_qr = 'stats.source_qr';
  static const String stats_source_direct = 'stats.source_direct';
  static const String stats_source_whatsapp = 'stats.source_whatsapp';
  static const String stats_source_call = 'stats.source_call';
  static const String stats_source_website = 'stats.source_website';
  static const String stats_source_email = 'stats.source_email';
  static const String stats_source_booking = 'stats.source_booking';
  static const String stats_profile_performance = 'stats.profile_performance';
  static const String stats_conversion = 'stats.conversion';
  static const String stats_saved = 'stats.saved';
  static const String stats_client = 'stats.client';
  static const String stats_visit = 'stats.visit';
  static const String stats_period_30d = 'stats.period_30d';
  static const String stats_period_7d = 'stats.period_7d';
  static const String stats_period_today = 'stats.period_today';

  // ─── Location Picker ────────────────────────────────────────────────────────
  static const String location_picker_title = 'location_picker.title';
  static const String location_picker_confirm = 'location_picker.confirm';
  static const String location_picker_resolving = 'location_picker.resolving';
  static const String location_picker_permission_denied =
      'location_picker.permission_denied';
  static const String location_picker_address_unavailable =
      'location_picker.address_unavailable';

  static const String account_guestTitle = 'account.guest_title';
  static const String account_welcome = 'account.welcome';
  static const String account_guestSubtitle = 'account.guest_subtitle';
  static const String account_continueAsGuest = 'account.continue_as_guest';
  static const String account_createAccount = 'account.create_account';
  static const String account_signIn = 'account.sign_in';
  static const String account_privacyPolicy = 'account.privacy_policy';
  static const String account_changeUsageType = 'account.change_usage_type';
  static const String account_title = 'account.title';
  static const String account_memberRole = 'account.member_role';
  static const String account_readyTitle = 'account.ready_title';
  static const String account_readySubtitle = 'account.ready_subtitle';
  static const String account_add = 'account.add';
  static const String account_sectionAccountData =
      'account.section_account_data';
  static const String account_editProfile = 'account.edit_profile';
  static const String account_helpCenter = 'account.help_center';
  static const String account_privacySecurity = 'account.privacy_security';
  static const String account_subscriptions = 'account.subscriptions';
  static const String account_usage = 'account.usage';
  static const String account_logout = 'account.logout';
  static const String account_language = 'account.language';
  static const String account_soon = 'account.soon';
  static const String account_sectionDashboard = 'account.section_dashboard';
  static const String account_statistics = 'account.statistics';
  static const String account_publishCard = 'account.publish_card';
  static const String account_editTitle = 'account.edit_title';
  static const String account_fullName = 'account.full_name';
  static const String account_jobTitle = 'account.job_title';
  static const String account_phone = 'account.phone';
  static const String account_email = 'account.email';
  static const String account_jobHint = 'account.job_hint';
  static const String account_phoneHint = 'account.phone_hint';
  static const String account_emailHint = 'account.email_hint';
  static const String account_changePassword = 'account.change_password';
  static const String account_saveEdit = 'account.save_edit';
  static const String account_editNote = 'account.edit_note';
  static const String account_notificationsTitle =
      'account.notifications_title';
  static const String account_offersTitle = 'account.offers_title';
  static const String account_offersSubtitle = 'account.offers_subtitle';
  static const String account_remindersTitle = 'account.reminders_title';
  static const String account_remindersSubtitle = 'account.reminders_subtitle';
  static const String account_followersTitle = 'account.followers_title';
  static const String account_followersSubtitle = 'account.followers_subtitle';
  static const String account_nfcTitle = 'account.nfc_title';
  static const String account_nfcSubtitle = 'account.nfc_subtitle';
  static const String account_messagesTitle = 'account.messages_title';
  static const String account_messagesSubtitle = 'account.messages_subtitle';
  static const String account_reportsTitle = 'account.reports_title';
  static const String account_reportsSubtitle = 'account.reports_subtitle';
  static const String account_notificationsNote = 'account.notifications_note';
  static const String account_privacyTitle = 'account.privacy_title';
  static const String account_profileLook = 'account.profile_look';
  static const String account_profileLookSubtitle =
      'account.profile_look_subtitle';
  static const String account_secondSide = 'account.second_side';
  static const String account_secondSideSubtitle =
      'account.second_side_subtitle';
  static const String account_profileVisibility = 'account.profile_visibility';
  static const String account_public = 'account.public';
  static const String account_publicVisibility = 'account.public_visibility';
  static const String account_twoStep = 'account.two_step';
  static const String account_enabled = 'account.enabled';
  static const String account_disabled = 'account.disabled';
  static const String account_passwordTitle = 'account.password_title';
  static const String account_change = 'account.change';
  static const String account_activeDevices = 'account.active_devices';
  static const String account_currentDevice = 'account.current_device';
  static const String account_deviceLogout = 'account.device_logout';
  static const String account_logoutOtherDevices =
      'account.logout_other_devices';
  static const String account_dataAndAccount = 'account.data_and_account';
  static const String account_downloadMyData = 'account.download_my_data';
  static const String account_deviceInfo = 'account.device_info';
  static const String account_storeSource = 'account.store_source';
  static const String account_version = 'account.version';
  static const String account_dataSize = 'account.data_size';
  static const String account_lastUpdate = 'account.last_update';
  static const String account_dangerTitle = 'account.danger_title';
  static const String account_edit = 'account.edit';
  static const String account_deleteAccount = 'account.delete_account';
  static const String account_subscriptionTitle = 'account.subscription_title';
  static const String account_currentPlanLabel = 'account.current_plan_label';
  static const String account_activeBadge = 'account.active_badge';
  static const String account_comparePlans = 'account.compare_plans';
  static const String account_upgradeChip = 'account.upgrade_chip';
  static const String account_yourCurrentPlan = 'account.your_current_plan';
  static const String account_pricePerMonth = 'account.price_per_month';
  static const String account_freePlanPrice = 'account.free_plan_price';
  static const String account_freePlanCard = 'account.free_plan_card';
  static const String account_freePlanFree = 'account.free_plan_free';
  static const String account_freeFeature1 = 'account.free_feature_1';
  static const String account_freeFeature2 = 'account.free_feature_2';
  static const String account_freeFeature3 = 'account.free_feature_3';
  static const String account_freeFeature4 = 'account.free_feature_4';
  static const String account_professionalPlan = 'account.professional_plan';
  static const String account_professionalPrice = 'account.professional_price';
  static const String account_professionalFeature1 =
      'account.professional_feature_1';
  static const String account_professionalFeature2 =
      'account.professional_feature_2';
  static const String account_professionalFeature3 =
      'account.professional_feature_3';
  static const String account_professionalFeature4 =
      'account.professional_feature_4';
  static const String account_professionalFeature5 =
      'account.professional_feature_5';
  static const String account_businessPlan = 'account.business_plan';
  static const String account_businessPrice = 'account.business_price';
  static const String account_businessFeature1 = 'account.business_feature_1';
  static const String account_businessFeature2 = 'account.business_feature_2';
  static const String account_businessFeature3 = 'account.business_feature_3';
  static const String account_businessFeature4 = 'account.business_feature_4';
  static const String account_subscriptionNote = 'account.subscription_note';
  static const String help_title = 'help.title';
  static const String help_faqSection = 'help.faq_section';
  static const String help_faq1Question = 'help.faq_1_question';
  static const String help_faq1Answer = 'help.faq_1_answer';
  static const String help_faq2Question = 'help.faq_2_question';
  static const String help_faq2Answer = 'help.faq_2_answer';
  static const String help_faq3Question = 'help.faq_3_question';
  static const String help_faq3Answer = 'help.faq_3_answer';
  static const String help_faq4Question = 'help.faq_4_question';
  static const String help_faq4Answer = 'help.faq_4_answer';
  static const String help_faq5Question = 'help.faq_5_question';
  static const String help_faq5Answer = 'help.faq_5_answer';
  static const String help_contactSection = 'help.contact_section';
  static const String help_subjectHint = 'help.subject_hint';
  static const String help_messageHint = 'help.message_hint';
  static const String help_send = 'help.send';
  static const String help_nfcGuide = 'help.nfc_guide';
  static const String help_reportProblem = 'help.report_problem';
  static const String help_termsOfUse = 'help.terms_of_use';
  static const String help_privacyPolicy = 'help.privacy_policy';
  static const String help_whatsappSupport = 'help.whatsapp_support';
  static const String help_whatsappSupportHint = 'help.whatsapp_support_hint';
  static const String help_emailSupport = 'help.email_support';
  static const String help_emailSupportHint = 'help.email_support_hint';
  static const String help_helpNote = 'help.help_note';
  static const String help_version = 'help.version';
  static const String clients_searchHint = 'clients.search_hint';
  static const String clients_filterAll = 'clients.filter_all';
  static const String clients_filterNew = 'clients.filter_new';
  static const String clients_filterContacted = 'clients.filter_contacted';
  static const String clients_filterQualified = 'clients.filter_qualified';
  static const String clients_filterConverted = 'clients.filter_converted';
  static const String clients_sourceLabel = 'clients.source_label';
  static const String clients_managedVia = 'clients.managed_via';
  static const String clients_minutesAgo = 'clients.minutes_ago';
  static const String clients_hoursAgo = 'clients.hours_ago';
  static const String clients_daysAgo = 'clients.days_ago';
  static const String clients_sourceQr = 'clients.source_qr';
  static const String clients_statusSheetTitle = 'clients.status_sheet_title';
  static const String clients_statusImportant = 'clients.status_important';
  static const String clients_statusLost = 'clients.status_lost';
  static const String clients_statusNotImportant =
      'clients.status_not_important';
  static const String clients_detailsTitle = 'clients.details_title';
  static const String clients_call = 'clients.call';
  static const String clients_whatsapp = 'clients.whatsapp';
  static const String clients_sendEmail = 'clients.send_email';
  static const String clients_saveContact = 'clients.save_contact';
  static const String clients_submissionData = 'clients.submission_data';
  static const String clients_submitDate = 'clients.submit_date';
  static const String clients_message = 'clients.message';
  static const String clients_source = 'clients.source';
  static const String clients_tags = 'clients.tags';
  static const String clients_addTag = 'clients.add_tag';
  static const String clients_notes = 'clients.notes';
  static const String clients_noNotes = 'clients.no_notes';
  static const String clients_meetings = 'clients.meetings';
  static const String clients_noMeetings = 'clients.no_meetings';
  static const String clients_tagImportant = 'clients.tag_important';
  static const String clients_tagUrgent = 'clients.tag_urgent';
  static const String clients_tagVip = 'clients.tag_vip';
  static const String clients_tagPotentialConversion =
      'clients.tag_potential_conversion';
  static const String clients_tagCurrentClient = 'clients.tag_current_client';
  static const String clients_tagReturned = 'clients.tag_returned';
  static const String clients_tagFollowUp = 'clients.tag_follow_up';
  static const String clients_tagOfferSubmitted = 'clients.tag_offer_submitted';
  static const String clients_followUp = 'clients.follow_up';
  static const String clients_noFollowUp = 'clients.no_follow_up';
  static const String clients_followUpDateHint = 'clients.follow_up_date_hint';
  static const String clients_followUpTimeHint = 'clients.follow_up_time_hint';
  static const String clients_followUpReasonHint =
      'clients.follow_up_reason_hint';
  static const String clients_save = 'clients.save';
  static const String clients_add = 'clients.add';
  static const String clients_addNoteAction = 'clients.add_note_action';
  static const String clients_noteHint = 'clients.note_hint';
  static const String clients_notesCount = 'clients.notes_count';

  static const String clients_empty = 'clients.empty';

  static const String account_login_company = 'account.login_company';
  static const String account_managing_Company = 'account.managing_company';
}
