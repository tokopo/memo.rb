require "csv"

# ===== メソッドの定義 =====

# csvファイルへの書き込み
def write(file_name, content, mode)
  CSV.open("#{file_name}.csv", mode) do |file|
    file << [content]
  end
end

def create
  puts "拡張子を除いたファイルを入力してください\n\n"
  input_name = gets.to_s.chomp
 
  file_name = File.basename(input_name, '.*')

  puts "メモしたい内容を入力してください。"
  puts "完了したらctr + d をおします"
  # memoの内容
  # content = gets.to_s.chomp
  # content = $stdin.read;puts content;
  content = STDIN.read
  write(file_name, content, 'w')
end

def show(file_name)
  CSV.foreach("#{file_name}.csv") do |row|
    body = row.join(',')
    if body.length > 20
      puts "内容：#{body.slice(0..20)}...\n\n"
    else
      puts "内容：#{body}\n\n"
    end
  end
end

def update
  puts "編集したいファイル名を入力してください（拡張子を除く）\n\n"
  input_name = gets.to_s.chomp
  file_name = File.basename(input_name, '.*')

  if File.exist?("#{file_name}.csv")
    show(file_name)
  else
    puts "#{file_name}が見つかりませんでした"
    exit
  end

  puts "更新する内容を入力してください\n\n"
  content = gets.to_s.chomp

  write(file_name, content, 'w')
end

# ===== //メソッドの定義 =====

puts "1(新規でメモを作成) 2(既存のメモ編集する)\n\n"

# ユーザーからの入力を待ち受ける
user_input = gets.to_i

case user_input
when 1
  create
  puts "メモを作成しました！"
when 2
  update
  puts "メモを更新しました！"
else
  puts 'アプリケーションを終了しました。'
end

