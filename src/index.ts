import { PrismaClient } from "@prisma/client"
import cors from "cors"
import dotenv from "dotenv"
import express, { Express, Request, Response } from "express"

import { CustomerData } from "./interfaces/CustomerData"
import { PaymentData } from "./interfaces/PaymentData"
import { SnackData } from "./interfaces/SnackData"

import CheckoutService from "./services/CheckoutService"

dotenv.config()

const app: Express = express()
const port = process.env.PORT || 5000
const prisma = new PrismaClient()

app.use(express.json())
app.use(cors())

app.get("/", (req: Request, res: Response) => {
  const { message } = req.body

  if (!message) return res.status(400).send({ error: "Message is required" })

  res.send({ message })
})

app.get("/snacks", async (req: Request, res: Response) => {
  const { snack } = req.query

  if (!snack) return res.status(400).send({ error: "Snack is required" })

  // SELECT * FROM Snack WHERE snack = 'drink'
  const snacks = await prisma.snack.findMany({
    where: {
      snack: {
        equals: snack as string,
      },
    },
  })

  res.send(snacks)
})

app.get("/snacks/maior", async (req: Request, res: Response) => {
  const { snack } = req.query

  if (!snack) return res.status(400).send({ error: "Snack is required" })

  //SELECT * FROM Snack WHERE snack = 'drink' ORDER BY price DESC;
  const snacks = await prisma.snack.findMany({
    where: { 
      snack: {
        equals: snack as string,
      },
    },
    orderBy: {price: 'desc'},
  })

  res.send(snacks)
})

app.get("/snacks/menor", async (req: Request, res: Response) => {
  const { snack } = req.query

  if (!snack) return res.status(400).send({ error: "Snack is required" })

  //SELECT * FROM Snack WHERE snack = 'drink' ORDER BY price ASC;
  const snacks = await prisma.snack.findMany({
    where: { 
      snack: {
        equals: snack as string,
      },
    },
    orderBy: {price: 'asc'},
  })

  res.send(snacks)
})

///////////////////////////////////////////




//////////////// 3 Junções de Duas Relações  ///////////////////


// Rota para obter os lanches e clientes para itens de pedidos pagos
/*
SELECT s.name AS snackName, c.fullName AS customerName
FROM OrderItem AS oi
JOIN "Order" AS o ON oi.orderId = o.id
JOIN Snack AS s ON oi.snackId = s.id
JOIN Customer AS c ON o.customerId = c.id
WHERE o.status = 'PAID'; */


app.get("/paid-orders", async (req: Request, res: Response) => {
  const paidOrders = await prisma.orderItem.findMany({
    where: {
      order: {
        status: "PAID",
      },
    },
    select: {
      snack: {
        select: {
          name: true,
        },
      },
      order: {
        select: {
          customer: {
            select: {
              fullName: true,
            },
          },
        },
      },
    },
  });

  res.send(paidOrders);
});

////////////////////////////////////////////////////



// Rota para obter todos os pedidos de um cliente
/*

SELECT o.id AS orderId, o.status, o.total, s.name AS snackName, s.price AS snackPrice
FROM "Order" AS o
JOIN Customer AS c ON o.customerId = c.id
JOIN OrderItem AS oi ON o.id = oi.orderId
JOIN Snack AS s ON oi.snackId = s.id
WHERE c.id = 1;
*/


app.get("/customer-orders/:customerId", async (req: Request, res: Response) => {
  const { customerId } = req.params;

  const customerOrders = await prisma.order.findMany({
    where: {
      customerId: Number(customerId),
    },
    include: {
      orderItems: {
        include: {
          snack: true,
        },
      },
    },
  });

  res.send(customerOrders);
});



///////////////////////////////////////////////////



// Rota para obter os itens de pedido por pedidoId

/** 
 * SELECT oi.id AS orderItemId, oi.quantity, oi.subTotal, s.name AS snackName, s.price AS snackPrice, o.id AS orderId, o.status, o.total, c.fullName AS customerName
FROM OrderItem AS oi
JOIN Snack AS s ON oi.snackId = s.id
JOIN "Order" AS o ON oi.orderId = o.id
JOIN Customer AS c ON o.customerId = c.id
WHERE o.id = <orderId>;
  */


app.get("/order-items/:orderId", async (req: Request, res: Response) => {
  const { orderId } = req.params;

  const orderItems = await prisma.orderItem.findMany({
    where: {
      orderId: Number(orderId),
    },
    include: {
      snack: true,
      order: {
        include: {
          customer: true,
        },
      },
    },
  });

  res.send(orderItems);
});

////////////////////////////////////////////





//////////////////3 Junções de Três ou Mais Relações //////////////////

// Rota para obter todos os pedidos de um cliente

/*

SELECT o.id AS orderId, o.status, o.total, s.name AS snackName, s.price AS snackPrice, c.fullName AS customerName
FROM "Order" AS o
JOIN Customer AS c ON o.customerId = c.id
JOIN OrderItem AS oi ON o.id = oi.orderId
JOIN Snack AS s ON oi.snackId = s.id
WHERE c.id = 1; */


app.get("/customer-orders/:customerId", async (req: Request, res: Response) => {
  const { customerId } = req.params;

  const customerOrders = await prisma.order.findMany({
    where: {
      customerId: Number(customerId),
    },
    include: {
      customer: true,
      orderItems: {
        include: {
          snack: true,
        },
      },
    },
  });

  res.send(customerOrders);
});



/////////////////////////////////////


// Rota para obter os pedidos com itens com quantidade maior que 2
/** 
 SELECT c.fullName AS customerName, SUM(o.total) AS totalSpent, oi.quantity, s.name AS snackName, s.price AS snackPrice
FROM Customer AS c
JOIN "Order" AS o ON c.id = o.customerId
JOIN OrderItem AS oi ON o.id = oi.orderId
JOIN Snack AS s ON oi.snackId = s.id
GROUP BY c.fullName, oi.quantity, s.name, s.price;
 */

app.get("/orders-with-items-quantity-greater-than-2", async (req: Request, res: Response) => {
  const ordersWithItemsGreaterThan2 = await prisma.order.findMany({
    where: {
      orderItems: {
        some: {
          quantity: {
            gt: 2,
          },
        },
      },
    },
    include: {
      customer: true,
      orderItems: {
        include: {
          snack: true,
        },
        where: {
          quantity: {
            gt: 2,
          },
        },
      },
    },
  });

  res.send(ordersWithItemsGreaterThan2);
});




// Rota para obter o valor total gasto por cada cliente
app.get("/customers-total-spent", async (req: Request, res: Response) => {
  const customersTotalSpent = await prisma.customer.findMany({
    select: {
      fullName: true,
      orders: {
        select: {
          total: true,
          orderItems: {
            select: {
              snack: {
                select: {
                  name: true,
                },
              },
            },
          },
        },
      },
    },
  });

  res.send(customersTotalSpent);
});














//////////////////2 funções de agregação sobre o resultado da junção de pelo menos duas relações//////////////////////

// Rota para obter o valor total gasto por um cliente específico
/* SELECT SUM(o.total) AS customerTotalSpent
FROM "Order" AS o
JOIN Customer AS c ON o.customerId = c.id
WHERE c.id = <customerId>;
 */

app.get("/customer-total-spent/:customerId", async (req: Request, res: Response) => {
  const { customerId } = req.params;

  const customerTotalSpent = await prisma.order.aggregate({
    where: {
      customer: {
        id: Number(customerId),
      },
    },
    _sum: {
      total: true,
    },
  });

  res.send(customerTotalSpent);
});



/* SELECT SUM(oi.quantity) AS customerTotalItems
FROM OrderItem AS oi
JOIN "Order" AS o ON oi.orderId = o.id
WHERE o.customerId = <customerId>;
*/

// Rota para obter o número total de itens em pedidos de um cliente
app.get("/customer-total-items/:customerId", async (req: Request, res: Response) => {
  const { customerId } = req.params;

  const customerTotalItems = await prisma.orderItem.aggregate({
    where: {
      order: {
        customerId: Number(customerId),
      },
    },
    _sum: {
      quantity: true,
    },
  });

  res.send(customerTotalItems);
});





///////////////////////////////////////////





////////////////Relatorios//////////////////


// Relatório de Vendas Totais por Lanche
app.get("/report-sales-by-snack", async (req: Request, res: Response) => {
  try {
    const salesBySnack = await prisma.orderItem.groupBy({
      by: ["snackId"],
      _sum: {
        quantity: true,
        subTotal: true,
      },
    });

    res.send(salesBySnack);
  } catch (error) {
    console.error("Error fetching sales by snack:", error);
    res.status(500).send("Internal Server Error");
  }
});

//Relatório de Pedidos Realizados por Cliente:
app.get("/report-orders-by-customer", async (req: Request, res: Response) => {
  try {
    const ordersByCustomer = await prisma.customer.findMany({
      select: {
        id: true,
        fullName: true,
        orders: {
          select: {
            id: true,
            total: true,
          },
        },
      },
    });

    res.send(ordersByCustomer);
  } catch (error) {
    console.error("Error fetching orders by customer:", error);
    res.status(500).send("Internal Server Error");
  }
});

//Relatório de Vendas Mensais:
app.get("/report-monthly-sales", async (req: Request, res: Response) => {
  try {
    const monthlySales = await prisma.$queryRaw`
      SELECT DATE_FORMAT(createdAt, "%Y-%m") AS month, SUM(total) AS totalSales
      FROM \`Order\`
      GROUP BY month
      ORDER BY month;
    `;

    res.send(monthlySales);
  } catch (error) {
    console.error("Error fetching monthly sales:", error);
    res.status(500).send("Internal Server Error");
  }
});


///////////////////////////////////////////////////////////////

app.get("/orders/:id", async (req: Request, res: Response) => {
  const { id } = req.params


/*SELECT * FROM "Order" AS o
LEFT JOIN "Customer" AS c ON o."customerId" = c."id"
LEFT JOIN "OrderItem" AS oi ON o."id" = oi."orderId"
LEFT JOIN "Snack" AS s ON oi."snackId" = s."id"
WHERE o."id" = [ID DO PEDIDO]; */

  const order = await prisma.order.findUnique({
    where: {
      id: +id,
    },
    include: { customer: true, orderItems: { include: { snack: true } } },
  })

  if (!order) return res.status(404).send({ error: "Order not found" })

  res.send(order)
})

interface CheckoutRequest extends Request {
  body: {
    cart: SnackData[]
    customer: CustomerData
    payment: PaymentData
  }
}



app.post("/checkout", async (req: CheckoutRequest, res: Response) => {
  const { cart, customer, payment } = req.body

/* Comandos que estão acontecendo dentro de checkout 

Criar um novo Cliente: INSERT INTO Customer (fullName, email, mobile, document, zipCode, street, number, complement, neighborhood, city, state)
Criar um novo pedido: INSERT INTO "Order" (status, total, customerId, transactionId)
Criar vários itens do pedido: INSERT INTO OrderItem (quantity, subTotal, orderId, snackId)
atualizar o valor total do pedido:UPDATE "Order"

 Prisma cuida da geração desses comandos SQL em segundo plano.Logo, o Prisma lidar com a interação com o banco de dados por meio do ORM.

*/


  const orderCreated = await new CheckoutService().process(
    cart,
    customer,
    payment
  )

  res.send(orderCreated)
})

app.listen(port, () => {
  console.log(`Server running on port ${port}`)
})
