require 'discordrb'
bot = Discordrb::Commands::CommandBot.new token: 'トークン', client_id:ID, prefix: '!'

bot.message(containing: "testbot") do |event|
  event.respond "こんにちは,#{event.user.name}さん"
end

bot.command :help do |event|
  event.respond "!connect...ボットがボイスチャンネルに入ります。\n!playlist...フォルダ内のファイルが表示されます。\n!play ファイル名...指定したファイルを再生します。\n!s...再生の停止\n!p...再生の一時停止\n!c...再生再開"
end

bot.command :connect do |event|
  channel = event.user.voice_channel
  next "ボイスチャンネルに入ってください" unless channel
  bot.voice_connect(channel)
  "ボットがボイスチャンネル(#{channel.name})に入りました。"
end

bot.command :playlist do |event|
  musicList = []
  Dir.chdir("music/") do 
    Dir.glob("*") do |m|
      musicList.push(m)
    end
  end
  musicList.join("\n")
end

bot.command :play do |event,m|
  if File.exist?("music/#{m}.mp3")
    event.voice.play_file("music/#{m}.mp3")
  else
    "ファイルがありません"
  end
end

bot.command :loop do |event|
  event.respond "loopはまだ未実装"
end

bot.command :s do |event|
  event.voice.stop_playing
end

bot.command :p do |event|
  event.voice.pause
end

bot.command :c do |event|
  event.voice.continue
end

bot.run
