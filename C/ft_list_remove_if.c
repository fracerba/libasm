/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lstadd_front.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fracerba <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/10/21 15:13:59 by fracerba          #+#    #+#             */
/*   Updated: 2022/10/21 15:14:01 by fracerba         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../libasm.h"

void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
    t_list	*tmp;
    t_list  *prev;
    t_list  *next;

	if (!begin_list || !*begin_list || !cmp || !free_fct)
        return ;
    tmp = *begin_list;
    prev = NULL;

    while (tmp)
    {
        next = tmp -> next;
        if (!cmp(tmp->data, data_ref))
        {
            free_fct(tmp -> data);
            free(tmp);
            if (prev)
                prev -> next = next;
            else
                *begin_list = next;
        }
        else
            prev = tmp;
        tmp = next;
    }
}