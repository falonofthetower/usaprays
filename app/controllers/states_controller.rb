class StatesController < ApplicationController
  layout "templates/states"

  WHAT_TO_PRAY_FOR = ['the SALVATION of those who have not yet put their faith in the Lord Jesus Christ',
                      'Wisdom',
                      'Discernment',
                      'Courage',
                      'Perseverance',
                      'Humility',
                      'Teachability',
                      'Moral Integrity',
                      'Self-Control'
  ]

  WHAT_TO_PRAY_FOR_MESSAGE = [
      "Political leaders, like all people, need the forgiveness of sins and the new life that comes through putting one's faith in Jesus Christ. 'God our Savior . . . . wants all men to be saved and to come to the knowledge of the truth' (1Timothy 2:3b-4). Praying for the salvation of political leaders should be a top priority in a Christian's life (Acts 4:10-12; Romans 10:9).",
      "Political leaders are regularly called upon to make very difficult decisions that affect many people. Divine wisdom is available for those who ask God for it (James 1:5). Good decisions will seldom be made without God's wisdom (Psalm 111:10).",
      "Sometimes there is a fine line between a right or a wrong decision. Every day a political leader is called upon to vote on an issue that may or may not be good for the people they represent. It is in these times they need Godly discernment (1 Kings 3:9).",
      "Political expediency often trumps a political leader's conscience. It is only with courage that a leader will trust that God is the protector and defender of all right decisions (2 Samuel 10:12).",
      "When political leaders act courageously and make right decisions they must be able to persevere through the pressure, tests and trials that will surely come their way. Even when their careers may be at stake, they must persevere and do the right thing (James 1:12; 2 Timothy 4:7).",
      "Political leaders have great power, deal with immense sums of money, and are often treated like royalty. This can quickly go to their heads and lead to arrogance and pride. Pray that God will keep them on their knees and heed His instruction; so that being led by Him they may rightly lead those they represent (1 Peter 5:5; Isaiah 66:2).",
      "When a political leader is wise and resists the temptation of pride, a teachable spirit will be evident (Proverbs 9:9; Ecclesiastes 4:13). We never know so much that God has nothing new to teach us.",
      "Political leaders regularly encounter strong temptations that include greed, deceitfulness, sexual immorality, and alcohol and drug abuse. They are often away from their families for many days at a time with little to no accountability. Pray for them to have the strength to resist these temptations that can destroy their lives, families, as well as their effectiveness as leaders (Psalm 25:21; Isaiah 33:15-16).",
      "Political leaders face daily temptations that can cause them to lose control of their attitudes and actions. They cannot control their circumstances but they can control their response to those circumstances. Prayer to maintain self-control is paramount for their success (Proverbs 25:28; 2 Timothy 1:7). The Message paraphrase interestingly translates Proverbs 16:32b, self-control is better than political power."
  ]

  def index
    render layout: "templates/application"
  end

  def show
    cookies[:state_code] = params[:id]
    @state = UsState.new(params[:id])
    @date = build_date
    @leaders = LeaderSelector.for_day(@state, @date)
    d = (Date.new(2000,1,1)-@date).to_i % 9
    @what_to_pray_for_text = WHAT_TO_PRAY_FOR[d]
    @what_to_pray_for_message = WHAT_TO_PRAY_FOR_MESSAGE[d]
    @what_to_pray_for_day = (d+1).to_s
    respond_to do |format|
      format.html
      format.rss { render :layout => false } #show.rss.builder
    end
  end

  def email
    @state = UsState.new(params[:id])
    @date = build_date
    @leaders = LegislatorSelector.for_day(@state, @date)
    d = (Date.new(2000,1,1)-@date).to_i % 9
    @what_to_pray_for_text = WHAT_TO_PRAY_FOR[d]
    @what_to_pray_for_message = WHAT_TO_PRAY_FOR_MESSAGE[d]
    @what_to_pray_for_day = (d+1).to_s
    render layout: false
  end

  private

    def build_date
      year = params[:year] || Date.current.year
      month = params[:month] || Date.current.month
      day = params[:day] || Date.current.day
      Date.new(year.to_i, month.to_i, day.to_i)
    end
end
