platform :ios, '9.0'

target 'TapIn' do
	
	use_frameworks!
	pod ‘Firebase/Core’
	pod ‘Firebase/Auth’
	pod ‘Stripe’

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
