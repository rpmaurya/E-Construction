const String kUrlBase =
    // "https://fb42-2405-201-4041-caf9-30f4-e425-9e24-6965.ngrok-free.app/";
    "http://ebasket.ap-south-1.elasticbeanstalk.com/";
const String kRegisterEndUrl = "users/register_user";
const String kLoginByMobileUrl = 'users/login_by_mobile';
const String kOtpVerifyByMobEndUrl = "users/mobile_verification";
const String kLoginByEmailEndUrl = "users/login_by_email";
const String kOtpVerifyByEmailEndUrl = "users/email_verification";
const String kGetUserByIdEndUrl = "users/get_user_by_id";
const String kUpdateUserById = 'users/update_UserDetail';
const String kGetCategoryListEndUrl = 'category/get_category_list';
const String kGetProductListEndUrl = 'product/get_products_on_categoryId';
const String kGetSubCategoryListEndUrl =
    'sub_category/get_sub_category_by_category_id';
// 'sub_category/get_sub_category_by_category_ids';
const String kGetCartProductListEndUrl = 'cart/get_cart_products_by_userid';
const String kUpdateCartProductListEndUrl = 'cart/update_quantity_of_product';
const String kAddtoCartEndUrl = 'cart/add_to_cart';
const String kBrandListtEndUrl = 'brand/get_brand_list';
const String kSearchListEndUrl = 'product/get_all_products';
const String kAddProductSubscriptionEndUrl =
    'subscription/add_product_subscription';
const String kUpdateSubscriptionEndUrl =
    'subscription/update_product_subscription';
const String kUpdateSubscptnTemporaryEndUrl =
    // 'subscription/update_product_subscription_temporarily';
    'subscription/update_product_subscription_temporarily';
const String kAddSubscriptionEndUrl = 'subscription/subscribe_product';
const String kGetTopProductEndUrl = 'product/get_top_products';
const String kGetSubscriptionEndUrl = 'subscription/get_user_subscriptions';
const String kResumeSubscriptionEndUrl =
    'subscription/resume_subscription_temporarily';
const String kDeleteSubscriptionEndUrl = 'subscription/delete_subscription';
const String kPauseSubscriptionEndUrl = 'subscription/pause_subscription';
