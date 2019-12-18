require 'active_support/time'

class ApiHistory < ApplicationRecord

  CALL_COUNT_MAX = 5000 * 0.8 # 楽天API使用回数最大値
  def self.is_usable?
    current_month = get_current_month
    if current_month.empty?
      # →レコードがなければ使用可
      return true
    else
      # →レコードがあれば、call_countが有効範囲内か確認する
      if current_month[0].call_count < CALL_COUNT_MAX
        return true
      else
        return false
      end
    end
  end

  def self.increment_call_count
    current_month = get_current_month
    if current_month.empty?
      # →レコードがなければ、call_count=1でレコード追加
      ApiHistory.create!(call_count: 1)
    else
      # →レコードがあれば、call_count+=1でレコード更新
      current_month[0].update!(call_count: current_month[0].call_count + 1)
    end
  end

  private
  def self.get_current_month
    # 現在の日時を取得
    current_time = Time.current
    # ApiHistoryから当月のレコードを取得
    return ApiHistory.where('created_at >= ? and created_at <= ?', "#{current_time.beginning_of_month}", "#{current_time.end_of_month}")
  end
end
