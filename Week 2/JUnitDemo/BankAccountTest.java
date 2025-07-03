import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.*;
class BankAccount {
    private int balance;

    public BankAccount(int initialBalance) {
        this.balance = initialBalance;
    }

    public void deposit(int amount) {
        balance += amount;
    }

    public void withdraw(int amount) {
        if (amount > balance) {
            throw new IllegalArgumentException("Insufficient funds");
        }
        balance -= amount;
    }

    public int getBalance() {
        return balance;
    }
}
public class BankAccountTest {

    private BankAccount account;

    @Before
    public void setUp() {
        account = new BankAccount(100);
        System.out.println("Set up fresh BankAccount");
    }

    @After
    public void tearDown() {
        System.out.println("Test completed\n");
    }

    @Test
    public void testDeposit() {
        account.deposit(50);
        assertEquals(150, account.getBalance());
    }

    @Test
    public void testWithdraw() {
        account.withdraw(40);
        assertEquals(60, account.getBalance());
    }

    @Test(expected = IllegalArgumentException.class)
    public void testWithdrawInsufficientFunds() {
        account.withdraw(200);
    }
}
