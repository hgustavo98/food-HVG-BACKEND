import { Customer, Order, OrderStatus } from "@prisma/client"

export default class PaymentService {
  async process(
    order: Order,
    customer: Customer
  ): Promise<{ transactionId: string; status: OrderStatus }> {
    try {
      const transactionId = this.generateTransactionId()
      const status = OrderStatus.PAID

      return {
        transactionId,
        status,
      }
    } catch (error) {
      console.error(
        "Error on process payment: ",
        JSON.stringify(error, null, 2)
      )
      return {
        transactionId: "",
        status: OrderStatus.CANCELED,
      }
    }
  }

  private generateTransactionId(): string {
    const randomTransactionId = Math.floor(Math.random() * 1000000).toString()
    return randomTransactionId
  }
}
