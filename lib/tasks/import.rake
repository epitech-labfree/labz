#
# Some rake tasks to import xxx.blowfish files, Epitech's style
#

namespace :import do

  task :users, [:bcrypt_file] => [:environment] do |t, args|
    args.with_defaults(:bcrypt_file => "ppp.blowfish")

    File.open args[:bcrypt_file], "r" do |f|
      f.each do |line|
        infos = line.split ' '
        puts infos[0]
        puts infos[1]

        begin
          u = User.new :login => infos[0],  :email => "#{infos[0]}@epitech.eu", :password => "isresetjustbelow"
          u.encrypted_password = infos[1]
          u.save!
        rescue
          puts "Got an exception : #{$!}"
        end
      end
    end
  end

  task :groups, [:passwd_file, :group_file] => [:environment] do |t, args|
    args.with_defaults(:passwd_file => "passwd", :group_file => "group")
    groups = Hash.new

    File.open args[:group_file], "r" do |f|
      f.each do |line|
        infos = line.split ":"
        g = Group.create(:name => infos[0], :gid => infos[2]) unless (g = Group.find_by_name infos[0])
        puts "Found group #{infos[0]}"
        groups[infos[2]] = g
      end
    end

    File.open args[:passwd_file], "r" do |f|
      f.each do |line|
        infos = line.split ":"
        u = User.find_by_email "#{infos[0]}@epitech.eu"
        puts u if u and groups.has_key? infos[3]
        if groups.has_key? infos[3] and (u = User.find_by_email "#{infos[0]}@epitech.eu")
          u.groups << groups[infos[3]] unless u.groups.exists? groups[infos[3]]
          puts "#{infos[0]} is in the group #{groups[infos[3]].name}"
        end
      end
    end
  end

end
