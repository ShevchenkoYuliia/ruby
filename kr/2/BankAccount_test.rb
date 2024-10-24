require_relative 'BankAccount'

RSpec.describe BankAccount do
  let(:account) { BankAccount.new(10000) }

  describe '#initialize' do
    it 'ініціалізація з балансом 0 і вказаним кредитним лімітом' do
      expect(account.balance).to eq 0.0
      expect(account.credit_limit).to eq 10000
    end
  end

  describe '#put_money' do
    it 'додає гроші на баланс при внесенні дійсної суми' do
      account.put_money(500)
      expect(account.balance).to eq 500.0
    end

    it "не додає грошей при від'ємній величині" do
      account.put_money(-100)
      expect(account.balance).to eq 0.0
    end
  end

  describe '#withdraw_money' do
    context 'коли достатньо коштів, включаючи кредитний ліміт' do
      it 'знімає гроші з балансу' do
        account.put_money(500)
        account.withdraw_money(300)
        expect(account.balance).to eq 200.0
      end

      it 'дозволяє зняти кошти за допомогою кредитного ліміту' do
        account.withdraw_money(9000)
        expect(account.balance).to eq -9000.0
      end
    end

    context 'коли недостатньо коштів' do
      it 'не дозволяє виводити більше, ніж доступні кошти' do
        expect { account.withdraw_money(15000) }.to output(/Insufficient funds/).to_stdout
        expect(account.balance).to eq 0.0
      end
    end

    it "не дозволяє виводити від'ємні суми" do
      expect { account.withdraw_money(-500) }.to output(/The amount must be greater than 0/).to_stdout
    end
  end
end
