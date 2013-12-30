# encoding: utf-8
require 'spec_helper'

describe Emojimmy do
  describe :token_to_emoji do
    let(:stored_text) { 'Hello :grin::grin: you :smiling_imp: :frog:!' }
    let(:returned_text) { 'Hello 😁😁 you 😈 🐸!' }

    subject { Emojimmy.token_to_emoji(stored_text) }
    it { should eql returned_text }
  end

  describe :emoji_to_token do
    context 'with a few emoji characters' do
      let(:received_text) { 'Hello 😁😁 you 😈 🐸!' }
      let(:stored_text) { 'Hello :grin::grin: you :smiling_imp: :frog:!' }

      subject { Emojimmy.emoji_to_token(received_text) }
      it { should eql stored_text }
    end

    context 'with *all* iOS emoji' do
      let(:received_text) do
        '😄😃😀😊☺😉😍😘😚😗😙😜😝😛😳😁😔😌😒😞😣
        😢😂😭😪😥😰😅😓😩😫😨😱😠😡😤😖😆😋😷😎😴
        😵😲😟😦😧😈👿😮😬😐😕😯😶😇😏😑👲👳👮👷💂
        👶👦👧👨👩👴👵👱👼👸😺😸😻😽😼🙀😿😹😾👹👺
        🙈🙉🙊💀👽💩🔥✨🌟💫💥💢💦💧💤💨👂👀👃👅👄
        👍👎👌👊✊✌👋✋👐👆👇👉👈🙌🙏☝👏💪🚶🏃💃
        👫👪👬👭💏💑👯🙆🙅💁🙋💆💇💅👰🙎🙍🙇🎩👑👒
        👟👞👡👠👢👕👔👚👗🎽👖👘👙💼👜👝👛👓🎀🌂💄
        💛💙💜💚❤💔💗💓💕💖💞💘💌💋💍💎👤👥💬👣💭
        🐶🐺🐱🐭🐹🐰🐸🐯🐨🐻🐷🐽🐮🐗🐵🐒🐴🐑🐘🐼🐧
        🐦🐤🐥🐣🐔🐍🐢🐛🐝🐜🐞🐌🐙🐚🐠🐟🐬🐳🐋🐄🐏
        🐀🐃🐅🐇🐉🐎🐐🐓🐕🐖🐁🐂🐲🐡🐊🐫🐪🐆🐈🐩🐾
        💐🌸🌷🍀🌹🌻🌺🍁🍃🍂🌿🌾🍄🌵🌴🌲🌳🌰🌱🌼🌐
        🌞🌝🌚🌑🌒🌓🌔🌕🌜🌛🌙🌍🌎🌏🌋🌌🌠⭐
        ☀⛅☁⚡☔❄⛄🌀🌁🌈🌊
        🏠🏡🏫🏢🏣🏥🏦🏪🏩🏨💒⛪🏬🏤🌇🌆🏯🏰⛺🏭🗼
        🗾🗻🌄🌅🌃🗽🌉🎠🎡⛲🎢🚢⛵🚤🚣⚓🚀✈💺🚁🚂
        🚊🚉🚎🚆🚄🚅🚈🚇🚝🚋🚃🚎🚌🚍🚙🚘🚗🚕🚖🚛🚚
        🚨🚓🚔🚒🚑🚐🚲🚡🚟🚠🚜💈🚏🎫🚦🚥⚠🚧🔰⛽🏮
        🎰♨🗿🎪🎭📍🚩🇯🇵🇰🇷🇩🇪🇨🇳🇺🇸🇫🇷🇪🇸🇮🇹🇷🇺🇬🇧
        1⃣2⃣3⃣4⃣5⃣6⃣7⃣8⃣9⃣0⃣🔟🔢#⃣🔣⬆⬇⬅➡🔠🔡🔤
        ↗↖↘↙↔↕🔄◀▶🔼🔽↩↪ℹ⏪⏩⏫⏬⤵⤴🆗
        🔀🔁🔂🆕🆙🆒🆓🆖📶🎦🈁🈯🈳🈵🈴🈲🉐🈹🈺🈶🈚
        🚻🚹🚺🚼🚾🚰🚮🅿♿🚭🈷🈸🈂Ⓜ🛂🛄🛅🛃🉑㊙㊗
        🆑🆘🆔🚫🔞📵🚯🚱🚳🚷🚸⛔✳❇❎✅✴💟🆚📳📴
        🅰🅱🆎🅾💠➿♻♈♉♊♋♌♍♎♏♐♑♒♓⛎🔯
        🏧💹💲💱©®™❌‼⁉❗❓❕❔⭕🔝🔚🔙🔛🔜🔃
        🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙
        🕥🕚🕦✖➕➖➗♠♥♣♦💮💯✔☑🔘🔗➰〰〽🔱
        ◼◻◾◽▪▫🔺🔲🔳⚫⚪🔴🔵🔻⬜⬛🔶🔷🔸🔹
        👎👊❔👌💛💢❔👊💙🌟❕
        👀👃👅👂👄'
      end

      let(:stored_text) { Emojimmy.emoji_to_token(received_text) }
      it { expect(stored_text.each_codepoint.to_a.max).to be <= 65535 }
    end
  end

  describe :strip do
    context 'with a few emoji characters' do
      let(:received_text) { 'Hello 😁😁 you 😈 🐸!' }
      let(:stripped_text) { 'Hello  you  !' }

      subject { Emojimmy.strip(received_text) }
      it { should eql stripped_text }
    end
  end
end
