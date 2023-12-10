class ApiV1EndPoints {
  static const baseurl = bool.fromEnvironment('development_mode')
      ? String.fromEnvironment('url_api_dev',
          defaultValue: 'http://oops.com.br/')
      : String.fromEnvironment('url_api_prod',
          defaultValue: 'http://oops.com.br/');
}
